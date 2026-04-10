Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C3A3BE163
	for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842843; cv=pass; b=K0JO/dUPAzT3OpjttOoD3eqSApjeyQBxg6H3P62eagE/mGe/EKaDSSxCPO0UGO3VZSx/bT/dlEib7Pz/Kv0j8mEHON0gbXaKmSM9Y+WMVXII/G4sUwbyWFI5LjquMUaUg1xfnANt8RKwvV2bTJ3oCb/8P7GyjGkCYAtmlsZOenA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842843; c=relaxed/simple;
	bh=EB+hFHu4o8mR5IB8DxbDE45H1JTJFvQueNfIGjdGdOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtX6Q5S5yYg3DJECfy4TPp2EaPOtSLFNLmvuPkp0b1qc7Jwmn3UzxIoZXNMtHMuLLo819KLVF3Wmm1HqOh1hp6J50tthTujDN5pRDxY93dFlEtKLfzrnkQ0Tw6KJtAo0eV3jNSluFmO8P+0uUPoeS7Egc/SOX9ItJTgKkEYtlDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyk6oZWb; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyk6oZWb"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9c11eba219so281761466b.2
        for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 10:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775842840; cv=none;
        d=google.com; s=arc-20240605;
        b=T7UguADRn8w69chJ6jnoQCvHk91oX9q/XuF1kAPDsobb5JIKZD7BLCnZHVw7knDjLR
         6BncMcWFD8bDjJOLsg6Am8dZfXwDgNjg1AnVC4Ye9fJInzp0hASPJ4RxfbvsqwU6/jTz
         U3ZsTbmdP/SwQpsi4Osdi7QbL1H9KCXMHsTpAwkfPAIDpbw4ElmG0nIQSB02T+9S6AKG
         V4C8zu1iLbbQH4liS9GHZXbrSiztanyZDHsQR2NRmyEu+nit/tLEtvCf7j3feq/yZoA9
         xbt5T5hipojmDR2THGSBOHUFJWsW/z2y0forToGC8cO5FQgXnHut7X8+lUD56FLX5jtF
         +AqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dN6OHHDaiTfVdHomxkKXHWudndDr0TAk+XE4EiflmuI=;
        fh=L9Ftw0ZdjDbBGFZLqpYeJ8hvhVVDd2PCMzQ5yLRZ87A=;
        b=EhSTRbkdH6po+Y1tt5dLM+a15sPx1dWvvR7hcL6mpBAgDg7lbpJu2jSl8DbjWuTzft
         6oCRozTdZpVdoG19logaSNYpCZ2ySJkaBRGbeBd//GMzxtiTlod7TRvUcDjA6wC+Se3W
         3X8E8MNLVHNzQ4jUIk6Nq+iCxW/7OwyGVHDVyT5vaTnza6mPZNevZaIN6KlTFfhRqP2z
         EuEMU/r5+n14oa0rK19MHU1mpJc3T/JwOXPqYM+Dfhuif+2JjH042ccfJvuA4QVq5AR2
         nOrgNRPtqDlCjp4YI5mlk31iqnueCCwa0Uh5ZjNwnhIjVaSD3iS1wzq+3InjKUJkA0mv
         4yXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775842840; x=1776447640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN6OHHDaiTfVdHomxkKXHWudndDr0TAk+XE4EiflmuI=;
        b=lyk6oZWbtyGzOzCJkXEAP+xRBcdymw/pLvvCJvJCkU076Bx9aby2Y6xsh3bnqZsWdP
         FEfqCc4EcgjSGvTFRGZgY1OuzCBwW2Zpu5lcGAlGo9Yq+VKlg6sxcScmOu+WXE0jnVra
         SoJRwKT8uPs3o7TEFsrc8p4gHacUnivZJYwBbsCQ6sb/97VK6ENzOBZvNfVeOB1O/8Jw
         eCNiFrjWTi4hNZU65mX6G0HZANqtmIs8yZ74RpajXgIvxGLvMLIai71hFUZk0Lx6nkbe
         zuLHBYOfq+me42TGxV/+nnjuxD5Gj45TCtqVGe7vMxC0APC5lPPB7FdTJjjxEPic/V44
         yxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775842840; x=1776447640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dN6OHHDaiTfVdHomxkKXHWudndDr0TAk+XE4EiflmuI=;
        b=bgVh9HprSqhizGgKCWbvu9+1HnOQlYwtw8oQNAH6qkJ1lyJG6vhFgbyiRNOCz0aHaf
         4F+JeDXt4JUarHBHksPLbsGoQg7MzH7JaaHcbqbKVv4L5Ehh6fgES66SsM+x4F4F9K0c
         webIIE3yWcMPvTdE/mkkaPa7XTwXakblC6c/AdLad+0vZH6LX+XX98IV7wDrOlk0Rs40
         x6cMuwmcFx+EUAZuPzO0BiSlzBY3MQK6WNb8HFhQmfSImkguMrSi4ciYI2I69SytB8cy
         6xYJ1bsbsANTsbv8/F75eOLcLS9JYpQ2zCiTHhHdLH5GFh5oUjTTT+3G9Bg6J1ANyLu6
         Wa+g==
X-Forwarded-Encrypted: i=1; AJvYcCUmufz3AjePo/gdnuM3MJEo+uToV6FHjsduTnJqJzvd5PSQN0+/DpYInqsPxw40PfK+mUmrylcMcf5+e35KSt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRsw/Bniimc8hIw4pE2NkhkVLyMZbnNsKjmFaNXews2OU9Uovk
	4BITA64n3Ia3XpYML04uQXZfN2ZloA+ddiSdoqFQ7ncTGQCPEF/147ovz4NK7tlJMHnPNst64pk
	MGJRxJIqv2GXHvQsw41uxRhPKeYoyZk0=
X-Gm-Gg: AeBDiesIdmQK/PXXUNYvjq9YJ/v5/O4FRFSLH6XGlk39D0aBCiK+JG8/hwifXHWen8S
	H4xrQRtlPY2JhLl6vg39sDdIh4YBg2czfXPm/nBvbEoaAXnOGHgKhDecc//HSNL1xSQ5XKHhs4W
	jfq+o+o1NHlhdpEkP7AGSVFKn9lqAwHkKMChYJLxfQ1Fd9xne2W3YUMJY8RXDmxFDWAgkmhVY89
	c5csvjgM2j9xvSS1y2OSM2kM8zbGMzzCIK6ucWd3441MJdlqWPaO8GVD6Rj6cBIJ9/rtIMDvU6c
	K5AHdWrjGZM/xuWfiHXeTpVoZL6DZZHHlSo374CYQPVhBV1kRIrDjtGDaG/TCd8+jOIFInXh6lo
	Vz/u5P3U6crz/kHTq
X-Received: by 2002:a17:906:eece:b0:b9c:350b:f849 with SMTP id
 a640c23a62f3a-b9d7297e205mr254084166b.24.1775842840105; Fri, 10 Apr 2026
 10:40:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401220643.12802-1-rosenp@gmail.com> <b772c81c-3628-45c5-ab11-a0737a94b812@oss.qualcomm.com>
In-Reply-To: <b772c81c-3628-45c5-ab11-a0737a94b812@oss.qualcomm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 10 Apr 2026 10:40:28 -0700
X-Gm-Features: AQROBzAGbFQNHO1NpZGhgy_hzsDylIa-uvfdzOOR1DS2GBgDZwb6wKvs4Zz0Xlg
Message-ID: <CAKxU2N96X31nsB-Vyt-Sm1rQMTo8cuZG+UDN=37av8c_5n-EcQ@mail.gmail.com>
Subject: Re: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, 
	Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:QUALCOMM CLOUD AI (QAIC) DRIVER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 10:01=E2=80=AFAM Jeff Hugo <jeff.hugo@oss.qualcomm.=
com> wrote:
>
> For future reference, $SUBJECT should have a space between "PATCH" and
> the version. git format-patch will do it correctly for you if you use
> the -v option.
>
> On 4/1/2026 4:06 PM, Rosen Penev wrote:
> > Consolidate the two-element allocation into a single allocation using a
> > flexible array member. This reduces memory fragmentation and simplifies
> > the error path by eliminating the need to check for allocation failure
> > between the two allocations.
> >
> > Add __counted_by for runtime bounds checking.
>
> This reword addresses my "why" comment on v1.  However I don't see that
> you responded to my question about how this was validated. I don't
> require a v3 of this patch, nor do I really want one. I want you to
> reply to this message and detail what validation you performed on this
> patch.
None. This is a straightforward conversion to a flexible array member
(and future devm_kzalloc_flex).
>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   v2: use macro for number of elements. reword commit message.
>
> Also for future reference, a blank line to separate the change log from
> the patch diff here makes the change log easier to find and read.
>
> >   drivers/accel/qaic/qaic.h     | 4 ++--
> >   drivers/accel/qaic/qaic_drv.c | 8 +++-----
> >   2 files changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
> > index fa7a8155658c..e237020f6aa9 100644
> > --- a/drivers/accel/qaic/qaic.h
> > +++ b/drivers/accel/qaic/qaic.h
> > @@ -152,8 +152,6 @@ struct qaic_device {
> >       struct list_head        cntl_xfer_list;
> >       /* Synchronizes MHI control device transactions and its xfer list=
 */
> >       struct mutex            cntl_mutex;
> > -     /* Array of DBC struct of this device */
> > -     struct dma_bridge_chan  *dbc;
> >       /* Work queue for tasks related to MHI control device */
> >       struct workqueue_struct *cntl_wq;
> >       /* Synchronizes all the users of device during cleanup */
> > @@ -206,6 +204,8 @@ struct qaic_device {
> >       void                    *ssr_mhi_buf;
> >       /* DBC which is under SSR. Sentinel U32_MAX would mean that no SS=
R in progress */
> >       u32                     ssr_dbc;
> > +     /* Array of DBC struct of this device */
> > +     struct dma_bridge_chan  dbc[] __counted_by(num_dbc);
> >   };
> >
> >   struct qaic_drm_device {
> > diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_dr=
v.c
> > index 63fb8c7b4abc..1dda8dfea5a4 100644
> > --- a/drivers/accel/qaic/qaic_drv.c
> > +++ b/drivers/accel/qaic/qaic_drv.c
> > @@ -43,6 +43,7 @@ MODULE_IMPORT_NS("DMA_BUF");
> >   #define QAIC_DESC                   "Qualcomm Cloud AI Accelerators"
> >   #define CNTL_MAJOR                  5
> >   #define CNTL_MINOR                  0
> > +#define DBC_NUM                              16
> >
> >   struct qaic_device_config {
> >       /* Indicates the AIC family the device belongs to */
> > @@ -405,15 +406,12 @@ static struct qaic_device *create_qdev(struct pci=
_dev *pdev,
> >       struct drm_device *drm;
> >       int i, ret;
> >
> > -     qdev =3D devm_kzalloc(dev, sizeof(*qdev), GFP_KERNEL);
> > +     qdev =3D devm_kzalloc(dev, struct_size(qdev, dbc, DBC_NUM), GFP_K=
ERNEL);
> >       if (!qdev)
> >               return NULL;
> >
> > +     qdev->num_dbc =3D DBC_NUM;
> >       qdev->dev_state =3D QAIC_OFFLINE;
> > -     qdev->num_dbc =3D 16;
> > -     qdev->dbc =3D devm_kcalloc(dev, qdev->num_dbc, sizeof(*qdev->dbc)=
, GFP_KERNEL);
> > -     if (!qdev->dbc)
> > -             return NULL;
> >
> >       qddev =3D devm_drm_dev_alloc(&pdev->dev, &qaic_accel_driver, stru=
ct qaic_drm_device, drm);
> >       if (IS_ERR(qddev))
> > --
> > 2.53.0
> >
>
