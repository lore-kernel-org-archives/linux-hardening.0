Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794263410;
	b=iIh0VAojtNwoGonGM22wbOUQjtrapHk8fPNQIZ44+ZBhhyeeil4NjtyLyC+x40VY815r
	 T8Fv3rXCIvsxKInDM8bbaDEN/sJZf0jImrjNOGCbx8j06E6TfFZmRjzVAiadGEsXOm7Z5
	 fr9ZKrSu05pi1WACDjmwPGiS3TqAS+sY2W9jz7x31Mh+qOolyyuue9gZ4HlQXPEIK8PGU
	 2YJgMY73oezIdByyiI/i3v2/VeIvQChZr1ICacw4NP/ZkYEPH/tBXu5Tv83ayBkejGD40
	 1Vs+sKOcd2JSjjthWSNXdZpUQoGl7KWKlzfuTkHkDfY4UK4glYAU3BkoWhUTCi3nU0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
	b=hEQzNfJ45JEiCOoFFB5LAzKDeRL0imYw8FyfYTjPwpz2eVkgHj4vaamPmTLnEkvje3aG
	 v2cf8QweqYflSWf18V5s223KfABvHdNB+sHTEGY5JQuCigHoE2KnkeDyPZz0zVXRih+S/
	 mOCJl2eajHrqWqu+4KSXi9umNnN76R4cQKSi5M33SLoD8nDYv4Zb9adsu7CL6AgtMj67N
	 qEhqmVEKmHiwL7WuWNUKDm27dRHK7G7ix0b9MnuRv5Oe1Tf/ddZLd9qxszgZ1/rjNI1+p
	 0sUzhhb/hcs8V8PPDmGgXxwl1aGeiRYkoQ3IQTpkAUfeaPePJ6N1xSIUug+1KMrT/ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528A606A321
	for <linux-hardening@vger.kernel.org>; Mon,  9 Nov 2026 22:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4528A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-535f598d126so39561cf.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Nov 2026 14:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794263408; cv=none;
        d=google.com; s=arc-20260327;
        b=ZWvjsEudUnAZKG/tTCpKxwGdvNTPd3kwK+DvyRx+ZUY3ZZQld27o/QWGRKMHP4OP6s
         Bq52vuKcOY6E0F7WMbF+bzH914CH6dacYxUR5rFmMg2qOnug5pkVemUowU1tV9TiR6sI
         Ix63qV888kN00fgv1gG5clL8lvpxs6LAcy2ASwNFV36SAdqGxW5oj2fOLQUoDvcsrQZv
         ykuiJbv9YRKQS8ojec25PgjLVIa1kxn+oDH3ZF+hjtJe7ZgNcSL3aZMenkvwUi6eMNQh
         VlTdRRwKzZaySlUlv4bg8BRx/zkgX/Wjh6Sa5/IW3AAuoHvFI/EqCh3idiYYhGClrdRV
         KLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        fh=5nkWKZY6ip4hEK53vwbrgAgabukmK3EkUPWPu5ra5CQ=;
        b=SZNd7Fl4hsrdFq/5fovek+WtfTc/2lI/YIFGBwAzf6AEoD/hnFOHUaz9+580VjLbGb
         1Orc2WEZhXjlSj38wBQMsDLCu97U/8HWUQ0EBoB7Uvl1M7J/8IMr/Efzl0YH9ELO7pHr
         80bfTQm8H7cmYYvflT8n2CbR6P1W7OOC4q/dqEDGNLiEyZk5iR9xvOkyTZXoR++wVOpP
         zphkNTvaNgrNE6wFZ8pOBflknPS3LlZVLu0LYQTIUGnKOCf77CW6xnivOD9tOMbAr222
         TF6/8AQHu7x1On6CX76zX3SF56LVlkadNXbXzoAP+xm27Cfrz8pPtFYUqpBVrVH1zE0A
         yfdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794263408; x=1794868208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=bc6ecKnXzqp5zahKN5US+W/GLFNu9bOCxLTorv75CdL/TyOgB/Qh6QFUi86M3M/XI3
         3gbxOXuAYS2+xcjqU4SLj5C27dCKM/SCCgBGdSbxDV00eICb4MzgEjo9vjECQ1QTCTmr
         MgCtojiqIWlVyB6AunwAs2qSQJP0tUdJsdT71C1y4WilJg+rQa++O5B+9FpAikzFpyGD
         TU94u5aUZCMHCz2bEPFushfsTW1bpin21NCA0WBKSF7omxyVw4eI3lnqeaGfI4JhzN5X
         ZQZwi7mBvwRBGIVH1EKWZ2xsmVHzuYxoBrVKANockiyw6pDDJKKlw7J5nTOQpM4hDjUm
         KR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263408; x=1794868208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=Nfbxembg/O5LslCMATM4XW+OO23MPsTE/pT9qazLGgcAw/ZS2Mm8jm8u0M7GvvCOgM
         o+p4tv1FkvLsJTYqJ/iKy8MlFp0BxMm9o6czLikg1dfG67qwtr6Vns4cvjLQXy8Q5pD6
         JC3O0mgmoe6OWU4jBhAPI9jH22oIcfjaIIwmAKDiaEY1t6z40lhno1pGnwhOgQrgs+8v
         mXgex6m6xqEuLLOFsjosMuHPYdm85KyPJxlQsRDipV+YEL2k/oxIp9esZdGHALSiKPXN
         B+abmBdXagsTdfo+B6j/9gluIi3OIk69EuDGST4Gg2JtW7hognUzc+38Pr2gGaMKRbWo
         /5Yw==
X-Forwarded-Encrypted: i=1; AL+hErG1IkYhkavl6vGaGvPw/0SXdSQN07XW7Nl4BjL8cIlZ5GGcutQInIAc+c1QKiA9W7e4zYieBEM8r6gpfXPp8Ho=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FW4Y6t/A/yU7F10W69DwIdmGIhPKitzAEl+u/Eh2Veo5+1idJ
	pny6UfsdRtwnp6Skzt2ULi8vpCoCIWNeBVUPQOlNskqQfrxdMLBIbb1kBWL1sInxEo1VRJb1xsk
	+0qmEiX37h9HTofscBM4OjAS7rLGHmKP07CVWUsYD
X-Gm-Gg: AYBFou2hQ7WzDoOI4c+s0KtGXnd7UEgqxGP+gHl5ozHLFn8LQwxJQ65juJW/3pzhXPa
	Le3iOPWYvl0xpOV+FKsLVkAigW3W/vcuODa3xsfxSls/9lDfHdhiRBWJM6SKCLU11kHmBN7okpJ
	X4aePQytGBm6zzJyNV9Acq4Up5sZb3RDCCAYzeOESa0niHexiV++jJ2/z6rMOfDkpyxDnB3F2zV
	xAgNbfKSNMTN1U1SSVo+rwsmDaELzjqDhmczBkwvswylu4848BJffJuyjj2u8p9ck/NLU79Bxeo
	GDp3M89RpGT6kWiW/1ye7OXCaeyKW9dZM9KzYAnZ6+1taM7wwZ2Stg4J3fB8YhPORiNJYU25Awh
	PRkSo0gKjUcp3/F9nkkfIZFr2mf34HLX7UhFYExBl8AG3CR5NnxV5r4I6+dabhG3WbkY=
X-Received: by 2002:a05:622a:1b16:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-555290bb288mr6464421cf.0.1794263407457; Mon, 09 Nov 2026
 14:30:07 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-7-irogers@google.com>
 <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
In-Reply-To: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 14:29:55 -0800
X-Gm-Features: AclHuK-dlWDp0B4FdK6V9QBR5LM_sA67_T-19O3ovPwDJ5RdBpzojQ18ICzxF_E
Message-ID: <CAP-5=fXd640kfaR+soPdiEV2mfqCPGDANCt04KzaXBphYP4Htg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
To: Juergen Gross <jgross@suse.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 10:56=E2=80=AFPM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 08.11.26 23:39, Ian Rogers wrote:
> > hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> > with kobject_create_and_add() (which allocates a dynamic kobject using
> > dynamic_kobj_ktype), and hypervisor_subsys_init() in
> > drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype wit=
h
> > &hyp_sysfs_kobj_type, which had no .release callback.
> >
> > Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> > kobject release behavior.
> >
> > Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   drivers/xen/sys-hypervisor.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.=
c
> > index 91923242a5ae..0e8a2cd69fd6 100644
> > --- a/drivers/xen/sys-hypervisor.c
> > +++ b/drivers/xen/sys-hypervisor.c
> > @@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops =3D {
> >       .store =3D hyp_sysfs_store,
> >   };
> >
> > +static void hyp_sysfs_release(struct kobject *kobj)
> > +{
> > +     kfree(kobj);
> > +}
> > +
> >   static const struct kobj_type hyp_sysfs_kobj_type =3D {
> > +     .release =3D hyp_sysfs_release,
> >       .sysfs_ops =3D &hyp_sysfs_ops,
> >   };
> >
>
> Wouldn't it make sense to have a common function for just kfree(kobj)?
>
> In your series there are 3 instances of .release just doing kfree(kobj).
>
> In case this is not wanted or with using the suggested common .release
> helper you can add my
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks Juergen!

lib/kobject.c already has a static dynamic_kobj_release() that does
this (and there are ~15 other places in the tree open-coding a static
kfree(kobj) release wrapper), so include/linux/kobject.h +
lib/kobject.c would be the natural home if we exported one.

I kept them as local static functions here for two reasons:

1. Patches 2/9, 3/9, and 6/9 carry Fixes: tags, and keeping the small
   local callbacks avoids a dependency on a new driver-core export for
   backports.
2. Since kobjects are normally embedded in a larger struct and freed via
   container_of(), I wasn't sure whether Greg and Danilo would view an
   exported kfree(kobj) release helper (especially alongside
   __must_init) as an invitation for misuse on embedded kobjects.

Unless Greg or Danilo would like dynamic_kobj_release() (or similar)
exported now, I'll plan to keep the local callbacks for this series
and can send a follow-up cleanup for the tree-wide callers if
driver-core maintainers think a shared helper makes sense.

Thanks,
Ian

>
>
> Juergen
