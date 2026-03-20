Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14C257ACF;
	Fri, 20 Mar 2026 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001781; cv=none; b=h+hZ46I5FLmEhAdXljtVfjYTIoS8GGnrip3SCIoCOFoFrTbivlY5cwb27q++McyuKGLKszLvtXFBGoQiAWm/yolI/nQvcFWigSB4pLGmlwGZ6/GuvtrdKbYkacldsbUUgK3KPjVwRiOVJ9HSAC6C7QkFuAlLSsw66PO0A7xs4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001781; c=relaxed/simple;
	bh=4tf3lo69WL/dl89+RrtD2T1YsCauaHjQmmzMHQKmpw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIUoihZEyBDRGKSQC5YsiZWWF6V9vDEUrz2++kE3rzXs4qEvVgCF9w5eoJWC+mQdCguAcj69YIpOESJi81gtex6i3vuTM9+TnnX2RyLY1TvG/ZjkZ4+HVr4COhVm5ds6+12QYu9kalgZ77X8LlAzm1cmA2uzAchNhjFtj86KnC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bjcH4c2h; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bjcH4c2h"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id CAD2B8D4;
	Fri, 20 Mar 2026 11:15:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1774001702;
	bh=4tf3lo69WL/dl89+RrtD2T1YsCauaHjQmmzMHQKmpw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjcH4c2h8SnvGzAtxtqtIVEAj4ouyVJmWt6aTY+bb3ZSey/hvCi1q8kBTqUvV5PjZ
	 SvzqMTOdRzAwinRWOXs5qf0+FmATjElfFRLzjx8o/RDbZf6hkeUyQzHI5AvnMdZGly
	 iPC9uT3cnsFeykIERcT3GZvunj4xTkNCBNyIAo28=
Date: Fri, 20 Mar 2026 12:16:14 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-media@vger.kernel.org, linux-hardening@vger.kernel.org,
	gustavoars@kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: nxp: imx8-isi: remove kzalloc_objs
Message-ID: <20260320101614.GA950194@killaraus.ideasonboard.com>
References: <20260306044536.149204-1-rosenp@gmail.com>
 <20260319220901.GD950375@killaraus.ideasonboard.com>
 <CAKxU2N856yYXURRf3td-_RCpe9hyX=zAy3qtD3ki23RjgO+a4Q@mail.gmail.com>
 <20260320005737.GE950244@killaraus.ideasonboard.com>
 <CAKxU2N81WEMkAPOVRHUORWodc21oW7wqvUJYVhd3uBJdLxRW4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N81WEMkAPOVRHUORWodc21oW7wqvUJYVhd3uBJdLxRW4w@mail.gmail.com>

On Thu, Mar 19, 2026 at 06:06:07PM -0700, Rosen Penev wrote:
> On Thu, Mar 19, 2026 at 5:57 PM Laurent Pinchart wrote:
> > On Thu, Mar 19, 2026 at 05:11:22PM -0700, Rosen Penev wrote:
> > > On Thu, Mar 19, 2026 at 3:09 PM Laurent Pinchart wrote:
> > > > On Thu, Mar 05, 2026 at 08:45:36PM -0800, Rosen Penev wrote:
> > > > > Use a flexible arraay member to combine allocations.
> > > > >
> > > > > It looks like pipes never gets freed anywhere. Meaning this effectively
> > > > > fixes a memory leak.
> > > > >
> > > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > > ---
> > > > >  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 11 ++++-------
> > > > >  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h |  3 ++-
> > > > >  2 files changed, 6 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> > > > > index 16392420903a..657ffecc4d7e 100644
> > > > > --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> > > > > +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> > > > > @@ -459,25 +459,21 @@ static const struct dev_pm_ops mxc_isi_pm_ops = {
> > > > >
> > > > >  static int mxc_isi_probe(struct platform_device *pdev)
> > > > >  {
> > > > > +     const struct mxc_isi_plat_data *pdata;
> > > > >       struct device *dev = &pdev->dev;
> > > > >       struct mxc_isi_dev *isi;
> > > > >       unsigned int dma_size;
> > > > >       unsigned int i;
> > > > >       int ret = 0;
> > > > >
> > > > > -     isi = devm_kzalloc(dev, sizeof(*isi), GFP_KERNEL);
> > > > > +     pdata = of_device_get_match_data(dev);
> > > > > +     isi = devm_kzalloc(dev, struct_size(isi, pipes, pdata->num_channels), GFP_KERNEL);
> > > > >       if (!isi)
> > > > >               return -ENOMEM;
> > > > >
> > > > >       isi->dev = dev;
> > > > >       platform_set_drvdata(pdev, isi);
> > > > >
> > > > > -     isi->pdata = of_device_get_match_data(dev);
> > > >
> > > > I'd keep
> > > >
> > > >         isi->pdata = pdata;
> > > >
> > > > here and not below.
> > >
> > > Sure
> > >
> > > > > -
> > > > > -     isi->pipes = kzalloc_objs(isi->pipes[0], isi->pdata->num_channels);
> > > >
> > > > Wouldn't it be simpler to just replace this with devm_kcalloc() ?
> > >
> > > That would only make sense if pipes remained a pointer. A flex array
> > > member allows combining allocations since it doesn't take up extra
> > > space.
> >
> > Yes, I understand that. My point was that with devm_kzalloc() here you
> > won't need to change the mxc_isi_dev structure. The leak fix will be a
> > one-liner patch.
> 
> Leak fix is not the point of the patch to be fair.

If I understand correctly, your main point is to combine two
allocations.

I don't liek this much in this specific case. mxc_isi_dev is the
top-level driver structure. As part of all the data it stores, there
is a pointer to a dynamically-allocated array, and the current
implementation happens to not have any other dynamically allocated
member. That is however not an intrinsic property of the mxc_isi_dev
structure. Treating pipes as a flex arrat within mxc_isi_dev won't scale
to a second similar member, and there's no reason to treat pipes in a
special way. I prefer fixing the leak and avoiding the flex array.

> > > Technically kzalloc_flex is simpler but I assume a devm version of
> > > that will be handled in another treewide commit.
> > > >
> > > >         isi->pipes = devm_kcalloc(dev, isi->pdata->num_channels,
> > > >                                   sizeof(isi->pipes[0]), GFP_KERNEL);
> > > >
> > > > No other change would be needed.
> > >
> > > With a flex array member, that's a compile time error, which I use as
> > > a hint to complete the conversion.
> > >
> > > > > -     if (!isi->pipes)
> > > > > -             return -ENOMEM;
> > > > > -
> > > > >       isi->num_clks = devm_clk_bulk_get_all(dev, &isi->clks);
> > > > >       if (isi->num_clks < 0)
> > > > >               return dev_err_probe(dev, isi->num_clks, "Failed to get clocks\n");
> > > > > @@ -487,6 +483,7 @@ static int mxc_isi_probe(struct platform_device *pdev)
> > > > >               return dev_err_probe(dev, PTR_ERR(isi->regs),
> > > > >                                    "Failed to get ISI register map\n");
> > > > >
> > > > > +     isi->pdata = pdata;
> > > > >       if (isi->pdata->gasket_ops) {
> > > > >               isi->gasket = syscon_regmap_lookup_by_phandle(dev->of_node,
> > > > >                                                             "fsl,blk-ctrl");
> > > > > diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> > > > > index 3cbd35305af0..99532efa4e41 100644
> > > > > --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> > > > > +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> > > > > @@ -286,7 +286,6 @@ struct mxc_isi_dev {
> > > > >       struct regmap                   *gasket;
> > > > >
> > > > >       struct mxc_isi_crossbar         crossbar;
> > > > > -     struct mxc_isi_pipe             *pipes;
> > > > >       struct mxc_isi_m2m              m2m;
> > > > >
> > > > >       struct media_device             media_dev;
> > > > > @@ -294,6 +293,8 @@ struct mxc_isi_dev {
> > > > >       struct v4l2_async_notifier      notifier;
> > > > >
> > > > >       struct dentry                   *debugfs_root;
> > > > > +
> > > > > +     struct mxc_isi_pipe             pipes[];
> > > > >  };
> > > > >
> > > > >  extern const struct mxc_gasket_ops mxc_imx8_gasket_ops;

-- 
Regards,

Laurent Pinchart
