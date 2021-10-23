Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65885C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 23 Oct 2021 11:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8B360FE7
	for <linux-hardening@archiver.kernel.org>; Sat, 23 Oct 2021 11:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhJWLbT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 23 Oct 2021 07:31:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:51903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJWLbS (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 23 Oct 2021 07:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634988521;
        bh=yOKngPoCbu6DtsIx/xx/DKQtmpvJ/9ZOA1akkMZBYws=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NcqsTAJ7H5m0zzWJDLvHnqFK8axb/sQMfcin60R0GffAM51o3jXG91d6xqL+CVfZo
         8s9h5B0TJZK7FuvBHhYxfPmt29zRgTpMvklPH729l6tEnHcNaGEAzxH/vxrbnXitnO
         ELRoJIo8OLWk2HalQzjdcgtiAshBkZ3MQf3RzvsE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiaY9-1n9ARb2eX9-00fmqG; Sat, 23
 Oct 2021 13:28:40 +0200
Date:   Sat, 23 Oct 2021 13:28:38 +0200
From:   Len Baker <len.baker@gmx.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prefer struct_size over open coded arithmetic
Message-ID: <20211023112838.GB4145@titan>
References: <20211017095650.3718-1-len.baker@gmx.com>
 <20211017172357.GA1214270@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017172357.GA1214270@embeddedor>
X-Provags-ID: V03:K1:q24hAsdZyZkzGXssf6uzzfSQUq54U9TAyYd0Z7aXuiRoUaczvVn
 S+DngOWqw4Q+T0ZTVoMD9ZYLb5Pv6EnSNEvaMohvt2iOI7jkIcipVtLI71UveHcGCdt7XUC
 XRifiSwxP26fft2hT0k2gnOy2ZKALSmC0PNmaIb4GL1nd7fBdT8XbkMyGAFgW4mzkPDDI/M
 Otq+WHQJvhvRUrTEBrBUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VS8SjNB1WTk=:sCNZLkoktU7b6nNoMVOEIO
 FsBuE498TTiJ6l0SbwDSTOvZdhkAmaJngBWfzoyL2BMKdtjqOHqUjtonXprBJZGEMQGLYk5zw
 BzlpJDno1v0CWbjCAwC4wMo+DLKMMpXVbh8bm85RGJy7OXOFtud132IACBvMmMCv6JS7z3ovz
 qIX3Ftb+1LaNT7dro5mP+KguvkI5tXOcny7yOPTsleg4SLFcspfQ0s2Oww40cpzYzsmOXMVJw
 eVP0846Tr9VE54s9SD1GonfX1xtJahKrolZgxvVh7o7BfwAlCtMPt02WSEf0vfQden+aqC6u4
 W6Bnf8K88EzP3Rje3raFGymFYjYeQq1SRaozREfuwJSo5LRDLo+71/rZ4doVPKpqkPgm26/rE
 J18jEGVBPFhSP1LBqEPUoIO4lGtf0Fu+h9j0KNboWFiz9unsJAVUK92J0afvhguk9Yp2Q3ieD
 6XAWO+IG+OSYEEj+RiHdp+WWJ/w5XP4Q9ZMbnTbe21iHrPNVSnLyFhbn73E4OtXOd1NvLpOxF
 CBcaNGODccwzAPCSEfOVMMU7/2z18Z64TtHH87CFHMEqnWU1TNvnwFILqcZp0xA/GKSPWhzpe
 44q7hSbUii8BT1T0kYt3ZTDVgkdivvDQyAwAM2BM0RevUhIXJ54zHe4PJDiTT9a0R7Y3e3VOe
 UkYC7XXt0QkKakBH0/8ffm8Xmcn2bWf5g1Cj7FFzwoLrHp6p5YIL5tKERjRCeFwnmZvANplNI
 yXuEYxKXTZBChtE8ruXSUSkgWltFuL/iBVG50Nr77QZaVSO1PEicr7zxPsXd+F59k+qXdJ5VZ
 UooAg6v+65O33xWe0KVZZlN7IuOOLqMG2FRjl3GfwxZ7uA4nVkiuga/ts9ZG6h1TGdwSoLHF+
 pCZlc1ICkFr7BNil6VdmDif8hkcjErciReoX97cGBJrJxpwx78T9yV6dbRpaERqcoVz+AlHfA
 Q12DQcYneAemFfNfcKYSbOq0z2SprvgIYKtjmRZQ4/sHEzVrjrIC4ZBs23rvl+V6FkDPrcYLu
 mdEzhZ1b0m8AidYHIxfZHc/KLTKBn/qZigcMP4+MiM1yPvYlKgUDcl7GzoPdvtzWnE4+nQ4Fs
 DtFYEyn7xXX9bI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Gustavo,

first of all, thanks for this review (and all others reviews as
well) ;)

More below.

On Sun, Oct 17, 2021 at 12:23:57PM -0500, Gustavo A. R. Silva wrote:
> On Sun, Oct 17, 2021 at 11:56:50AM +0200, Len Baker wrote:
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or simila=
r)
> > function arguments due to the risk of them overflowing. This could lea=
d
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> >
> > In this case this is not actually dynamic size: all the operands
> > involved in the calculation are constant values. However it is better =
to
> > refactor this anyway, just to keep the open-coded math idiom out of
> > code.
> >
> > So, use the struct_size() helper to do the arithmetic instead of the
> > argument "size + count * size" in the kmalloc() function.
> >
> > This code was detected with the help of Coccinelle and audited and fix=
ed
> > manually.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#ope=
n-coded-arithmetic-in-allocator-arguments
> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> > ---
> > Hi,
> >
> > this patch is built against the linux-next tree (tag next-20211015).
>
> You don't need to include these lines in every patch. Just add [next]
> to the subject line, like this:
>
> 	[PATCH][next] nvmet: prefer struct_size over open coded arithmetic
>
> It should be clear enough for people that you are talking about
> linux-next. And in case someone asks, then you proceed to clarify. :)

Ok, understood. Thanks for the advise.

> > Regards,
> > Len
> >
> >  drivers/nvme/target/admin-cmd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/adm=
in-cmd.c
> > index aa6d84d8848e..4aa71625c86a 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -278,8 +278,8 @@ static void nvmet_execute_get_log_page_ana(struct =
nvmet_req *req)
> >  	u16 status;
> >
> >  	status =3D NVME_SC_INTERNAL;
> > -	desc =3D kmalloc(sizeof(struct nvme_ana_group_desc) +
> > -			NVMET_MAX_NAMESPACES * sizeof(__le32), GFP_KERNEL);
> > +	desc =3D kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
> > +		       GFP_KERNEL);
>
> It might be worth exploring if the flexible array is actually needed,
> once the allocation is always determined by NVMET_MAX_NAMESPACES. Maybe
> it can be changed to the following and remove the dynamic allocation
> entirely?
>
> 	struct nvme_ana_group_desc {
> 		__le32  grpid;
> 		__le32  nnsids;
> 		__le64  chgcnt;
> 		__u8    state;
> 		__u8    rsvd17[15];
> 		__le32  nsids[NVMET_MAX_NAMESPACES];
> 	};

What's the size limit for dynamic allocation vs stack allocation? I think
that NVMET_MAX_NAMESPACES * sizeof(__le32) =3D 1024 * 4 =3D 4096 bytes is =
big
enough (but I don't know if it is the correct way to think).

However, due to the following comment in the NVMET_MAX_NAMESPACES macro
definition:

/*
 * Nice round number that makes a list of nsids fit into a page.
 * Should become tunable at some point in the future.
 */
#define NVMET_MAX_NAMESPACES	1024

I think that it is better to use the dynamic allocation since in the
future the struct size could be dynamic.

>
> If the above is possible then (at least) these lines should be audited:
>
> drivers/nvme/host/multipath.c-551-              if (WARN_ON_ONCE(offset =
> ctrl->ana_log_size - sizeof(*desc)))
>
> drivers/nvme/host/multipath.c-566-              offset +=3D sizeof(*desc=
);
> drivers/nvme/host/multipath.c-567-              if (WARN_ON_ONCE(offset =
> ctrl->ana_log_size - nsid_buf_size))
>
> If the flexible array remains, then this line could use
> flex_array_size():
>
> drivers/nvme/host/multipath.c-555-              nsid_buf_size =3D nr_nsi=
ds * sizeof(__le32);

Ok. I didn't see it.
>
> struct_size() could be used here, as well:
>
> drivers/nvme/host/multipath.c-847-      ana_log_size =3D sizeof(struct n=
vme_ana_rsp_hdr) +
> drivers/nvme/host/multipath.c:848:              ctrl->nanagrpid * sizeof=
(struct nvme_ana_group_desc) +
> drivers/nvme/host/multipath.c-849-              ctrl->max_namespaces * s=
izeof(__le32);

Sorry, but here it's not possible to use struct_size() due to

sizeof(struct nvme_ana_group_desc) + ctrl->max_namespaces * sizeof(__le32)

it's not one single element. The "sizeof(struct nvme_ana_group_desc)" is
multiplied by "ctrl->nanagrpid" and then added "ctrl->max_namespaces * siz=
eof(__le32)".

> drivers/nvme/target/admin-cmd.c:267:    return sizeof(struct nvme_ana_gr=
oup_desc) + count * sizeof(__le32);

Ok. I forgot it. Apologies.

Again, thanks for your time and advises,
Len
