// ignore_for_file: deprecated_member_use
import 'package:capef/assets.dart';
import 'package:capef/utils/functions.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class BuildImageNetwork extends StatefulWidget {
  const BuildImageNetwork(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.opacity,
    this.fit,
    this.isLoadingBuilderShimmer = false,
    this.isColorBlendMode = false,
    this.cacheWidth,
    this.cacheHeight,
    this.borderRadius,
    this.version,
    this.useCach,
    this.onLoadComplete,
    this.showNotifySVG,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final double? opacity;
  final BoxFit? fit;
  final bool isLoadingBuilderShimmer;
  final bool isColorBlendMode;
  final int? cacheWidth;
  final int? cacheHeight;
  final BorderRadius? borderRadius;
  final int? version;
  final bool? useCach;
  final VoidCallback? onLoadComplete;
  final bool? showNotifySVG;

  @override
  State<BuildImageNetwork> createState() => _BuildImageNetworkState();
}

class _BuildImageNetworkState extends State<BuildImageNetwork>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
        child: (widget.imageUrl != null &&
                widget.imageUrl != '' &&
                GlobalFunctions.isValidImageUrl(widget.imageUrl ?? ''))
            ? ExtendedImage.network(
                widget.imageUrl ?? '',
                compressionRatio: 0.7,
                imageCacheName: '${widget.imageUrl}_${widget.version}',
                width: widget.width,
                height: widget.height,
                fit: widget.fit ?? BoxFit.cover,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.3),
                        highlightColor: Colors.grey.withOpacity(0.1),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Set the color to something that shimmers
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: widget.width,
                          height: widget.height,
                        ),
                      );

                    case LoadState.completed:
                      widget.onLoadComplete?.call();
                      return null;
                    case LoadState.failed:
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widget.showNotifySVG == true
                              ? const SizedBox()
                              : SvgPicture.asset(
                                  Assets.icons.logoSvg,
                                  colorBlendMode: widget.isColorBlendMode
                                      ? BlendMode.darken
                                      : BlendMode.clear,
                                  color: widget.isColorBlendMode
                                      ? Colors.black.withOpacity(0.3)
                                      : null,
                                  width: widget.width,
                                  height: widget.height,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      );
                  }
                },
                colorBlendMode:
                    widget.isColorBlendMode ? BlendMode.darken : null,
                color: widget.isColorBlendMode
                    ? Colors.black.withOpacity(0.3)
                    : null,
                cache: widget.useCach ?? true,
                enableMemoryCache: true,
              )
            : SvgPicture.asset(
                Assets.icons.logoSvg,
                colorBlendMode: widget.isColorBlendMode
                    ? BlendMode.darken
                    : BlendMode.clear,
                color: widget.isColorBlendMode
                    ? Colors.black.withOpacity(0.3)
                    : null,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
