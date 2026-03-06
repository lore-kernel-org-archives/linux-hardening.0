Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5CC2D8DD6
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824598; cv=pass; b=tcAiNGPOQthERaz2Kjjwi8IuLcjkohxtCYxAWx83cjZHMKZJ355xq6SkFeToMEG3EhGKsp/nWYtfyUrXMqHx4nQ2FMvF7NqdupIBMxlpuAecPP5uUuReXo/cd8QYS67Uh2xcJRjCi8RW9AtG9tX9idfceOUJcnLilhIswc/X7OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824598; c=relaxed/simple;
	bh=9g511vcaQ68wgb3bgfddkmWSMclMBk8o4icbii7da0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCy+Xw4hOHP8PmX76XIXItxTHpQivuX1j5ezMn0IPDcXtrGHMapqUm9eY65DtVO2sjuIzvENW8mqeqcc492EKjLrDen07QNzf7yzp7IpowTF/a3g3hjRohV/jMBDbqir7ubxUCKY9IjeA7864tZuJk23KLD+h3UWTiagyfrp2YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6mjE6ZM; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6mjE6ZM"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9372552059so1336729066b.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 11:16:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772824595; cv=none;
        d=google.com; s=arc-20240605;
        b=LsXo6T40DU1qiE+eYYTg92r0ydKvE0B8wHduLVFZvB4nErywjvHBm3Qz0NzR5WNa3x
         7trFwKJ0YEIgkZMhZhIcS/4lQQKdxN4bB6PA9+OprSCkbi38pWykyNwKVAJF2m6YokKJ
         +WxtdtpYduTiiJGGzQCqXuxSAJwnp6hQ99oqtRL2KES/kz4uIpbdPiA4P+RV5vhiihsw
         W39sCtGWVXs1KJXhvNprBKS4eiKay45RM/oD6+1hGVCLzhiYfC9v9MjkZCaYi/zIr+Ko
         8drxrRkTHysNzA7ANiMWFD5AEtv0bnREoj01oJguwcSawGktlMx2tI82vyJZZP6+W0Iq
         gXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RQl/k7H5TnGsHgAzmX0qeb615hkvz32yF+5OyK+sVKA=;
        fh=+ioP54uNfgnezUA3WEYig1M0yVQ0LxDSFXT5o7u6JhI=;
        b=VzS+/ZRqyRA5KNdSNZvS5GIfh+N69IIMnI7pY6cAMnqYiZHm06cR5vFx+SF5/vavC7
         UeN7oJzgKRvXWCHPPcbUGJ5quUhFHd6Ms+3OPPHe6PpnfI4GQLXwcO0YajSvcIxpUawR
         MEM0Ln3ggEZE3tnFoMKIZhO6brVTlOUHCT0S4U+FgpCmG6ARBXKRxBYR1jRSI7sup8f7
         /wdPqRu9Fwg79Rc3u/aNGcyQLAWLntx6fQojM4fVOXHqozCJuElsLYMbsrp2DdCKDXlt
         g8nD+S0+jtWkLzbaydNzM58Ef8kg5C9opnP5ClBFL+Oj40RYXcGKcv3AVD5qqtkXSGgH
         +lBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772824595; x=1773429395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQl/k7H5TnGsHgAzmX0qeb615hkvz32yF+5OyK+sVKA=;
        b=i6mjE6ZMC7PD48yo7brB/zqSXwNRdoR1wsPtOWzGWet9aOJ196OnPx+4kJFKVQ+JIF
         RsTHSDbIipZN2D1jYUGdWZMBaqKFn23emJy1x7xHzjX/Q89i5uDNrTJCJGWmFMntKP4H
         oGkOnC6iRl+TiGB8dKXE1x77kh+3RFHnRI7cf9gMax1cxzqLuzgKUuOWRA5z9fHHR4/b
         msavt7vfEq5TGW6FIx6VVWNaxW1A/l2GpTw+TxO2eBFeASI6boTTYPOnw5+mCgYYdENc
         kMVmSikK7ShXQxVb/T1vCMqwmJjWzdVkl2z2j3vQraZQ48EZHn6Fk1ZL98vC/TA8tBTm
         RUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772824595; x=1773429395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQl/k7H5TnGsHgAzmX0qeb615hkvz32yF+5OyK+sVKA=;
        b=U4H0WZJuVlEFs8TRDDjUeubKGmQbNGJSfB7jUHpQMI55YW60+rx/+xM1tEjE9ad9cG
         jnhxedvsyUGU2byJVqyGZHSBp9Gc+Ly37uFWjEYxUKWDoEHw+3B+uMgLsOfh2anJKOYV
         +a+hdhJffShYlNBpdPjcuTf0rdBNHhI4hfIh4QLRXKckBBnvEmE8Sy42XzEB0WxOGG5J
         PRai5IU2qgYoFLUV3RctZELGBZpII+jqxLQ33YmH4IJ+BoozNS2W71Fwj0m/Gcg/lrbP
         NloFeEBAuWocGh/fUIzayRik/22zwrR7tF8QGcLrIlkNOHU8nb4WM7eGXzpg7IiW5btj
         xDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaDvBNR42E+wSesDMpBhhMjLNEek3bDekTeBBV89gNa/XWcb3TW4LMd+glqkZt1MbnI4xxFxswf7uikxSAAm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+vmxgYgNt9NV8z03ge5ca1LZNSfgmG58nuuqeaD065r0kTJf
	ZA/INJodEd8cAphJBWFda2/saN2EXeHC2EbBllz/0E3GyqJ163+yWqjbzqgjKb+1llyyrAQ2Z2n
	HhBxqpaSEX8Pk5RH7hNgpkhLPC/tMBok=
X-Gm-Gg: ATEYQzwfTGVVGUnVg0Ir/UBDMxrhp4OXF4sIGxGPClsm3NgQHBaFjx/VmJfJ4QLWWg6
	rShmSEf3NjfVWYnUjwbic76FFVVAbUt2sRC5VhYZ3vLPvyD6qDG2nW2m0eyHzeIvpPSVrIYsyoz
	6W+9OFT5/ABlx1a7EaU4I0ADh7gMtwj6+l0YffPiZ3Dz4qLsBknRmprgG1Gv9eo+mGvdfcqsrU2
	wfVboujaTs9pCdzpjyu1tC35W7xBGB/LUybBWkOL4ztV++RcEQ6bMiF44BzRR/DjD21hxORGUec
	+TBF5fnbfesSVdFi0PZF//PNdRm74aiyZXZNeueKADwRQpfmsgB0fHqYya4j/6EEW4RV1IVz9rD
	mxTI/8dFduSTB1fOT
X-Received: by 2002:a17:907:96a3:b0:b8e:4790:d7cf with SMTP id
 a640c23a62f3a-b942e0249b9mr197709866b.53.1772824594561; Fri, 06 Mar 2026
 11:16:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306031639.46942-1-rosenp@gmail.com> <be17111e-1c78-49ca-8bae-fadcd7af6905@embeddedor.com>
In-Reply-To: <be17111e-1c78-49ca-8bae-fadcd7af6905@embeddedor.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 6 Mar 2026 11:16:23 -0800
X-Gm-Features: AaiRm50wLh1_AThkRv_BjNof7MflCw4QqkJP8CGHD5V--3_dfluZWxf4oemtoVM
Message-ID: <CAKxU2N_qu73NFFaJqd+ejg855L-RvaPvQvEmGLqTUpnO5iOUxQ@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: kzalloc + kcalloc to kzalloc_flex
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-usb@vger.kernel.org, Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 10:54=E2=80=AFAM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 3/6/26 12:16, Rosen Penev wrote:
> > Simplifies allocation and allows using __counted_by for extra runtime
> > analysis.
>
> Are you finding these with Coccinelle or any other tool?
git grep -B 10 zalloc_objs\( | grep zalloc\(
git grep -B 10 calloc\( | grep zalloc\(

And seeing if it's something that can easily be dealt with. The
__counted_by thing is usually clear in _probe if it's correct.
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Thanks
> -Gustavo
>
> > ---
> >   drivers/usb/typec/tcpm/tcpm.c | 19 +++++--------------
> >   1 file changed, 5 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcp=
m.c
> > index 1d2f3af034c5..272f9187b12d 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -605,9 +605,9 @@ struct altmode_vdm_event {
> >       struct kthread_work work;
> >       struct tcpm_port *port;
> >       u32 header;
> > -     u32 *data;
> >       int cnt;
> >       enum tcpm_transmit_type tx_sop_type;
> > +     u32 data[] __counted_by(cnt);
> >   };
> >
> >   static const char * const pd_rev[] =3D {
> > @@ -1653,7 +1653,6 @@ static void tcpm_queue_vdm_work(struct kthread_wo=
rk *work)
> >       tcpm_queue_vdm(port, event->header, event->data, event->cnt, even=
t->tx_sop_type);
> >
> >   port_unlock:
> > -     kfree(event->data);
> >       kfree(event);
> >       mutex_unlock(&port->lock);
> >   }
> > @@ -1662,35 +1661,27 @@ static int tcpm_queue_vdm_unlocked(struct tcpm_=
port *port, const u32 header,
> >                                  const u32 *data, int cnt, enum tcpm_tr=
ansmit_type tx_sop_type)
> >   {
> >       struct altmode_vdm_event *event;
> > -     u32 *data_cpy;
> >       int ret =3D -ENOMEM;
> >
> > -     event =3D kzalloc_obj(*event);
> > +     event =3D kzalloc_flex(*event, data, cnt);
> >       if (!event)
> >               goto err_event;
> >
> > -     data_cpy =3D kcalloc(cnt, sizeof(u32), GFP_KERNEL);
> > -     if (!data_cpy)
> > -             goto err_data;
> > -
> >       kthread_init_work(&event->work, tcpm_queue_vdm_work);
> > +     event->cnt =3D cnt;
> >       event->port =3D port;
> >       event->header =3D header;
> > -     memcpy(data_cpy, data, sizeof(u32) * cnt);
> > -     event->data =3D data_cpy;
> > -     event->cnt =3D cnt;
> > +     memcpy(event->data, data, sizeof(u32) * cnt);
> >       event->tx_sop_type =3D tx_sop_type;
> >
> >       ret =3D kthread_queue_work(port->wq, &event->work);
> >       if (!ret) {
> >               ret =3D -EBUSY;
> > -             goto err_queue;
> > +             goto err_data;
> >       }
> >
> >       return 0;
> >
> > -err_queue:
> > -     kfree(data_cpy);
> >   err_data:
> >       kfree(event);
> >   err_event:
>
