Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE91863E;
	Tue, 25 Feb 2025 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446183; cv=none; b=AVpvY33gZIPcYXTmgsxC0qP/JgsIU1RVrJO5dPkQ0xLf3PSGKZmAzc/oggZoWBFuugYJsUQCuW4RzbbbO9LUMm3lGmUM5fvPZ0pMzD4iO6uow3gJkdmuNKUdVOzJZaUM0GodUzXUEFyyDUm15YGTB1UGzxALgDpBw7kOlqGQsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446183; c=relaxed/simple;
	bh=RL9H0TzNeattZGkSPMVJRj96UBctzI2uDH4672BeEYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELCgXswvasnQpXnJBYpiaELmi7pbiY0R5VTvOfM8zKF3G14DP++MwfkOU5aqREmg5umzY3nLuvV7zuYKzdcElAcNUPwJ1rkoclPpmZUCCYU91uY+4ZnHJuUFld51nBfZaJbM0IYjbh8WkoUE2biGjrMxkkDlEYVecklDlUJp7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcisDk/0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcisDk/0"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so6871789a12.0;
        Mon, 24 Feb 2025 17:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740446179; x=1741050979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=USud5gyYtWrU8U8QerFLgqPcIKFBmDezEDg0FlIDuDg=;
        b=FcisDk/0D34gX08pV3mCzUDLHWVXDRr8WlXW9LQ4MA8ZEOL2+rvfUTKAHTv1oXDr0o
         sBOyRs+hQKrRbQ7sye2hwOqppz6g+g1JnVI2xMZvMoLvDkVJQ6xF9Dt1O1AGzI2qHWsO
         uHjKjq6jc/tEQbyt5LHItPLyReB0npgGdRcIlBNCP68xM148FeFU0RFRno+mO8BrOklv
         kEp6OlKyfUaba/tdPxiGDN3yiQqtazY6JIWD730Cd7QAfjMuOVcUD7mvfr7hN6sDP9d+
         /yhPRA6jc3y8NVHK3WQH6i67kWOp9XLDgY20Ef5q9aIXAnmdyjxRN+IrXc8Hy2AEJBVb
         SnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740446179; x=1741050979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USud5gyYtWrU8U8QerFLgqPcIKFBmDezEDg0FlIDuDg=;
        b=jVjWgCpyakt44WWVGhvI9CwsOnpExx1JI4O0AswXvKmKXsTFbidQXR4bgzKGGpn/h3
         jMNJFJoYsmt/bq6AUXj5GKbggY3aZDZPjZIexE4ndc4dgtUmcOBDjO5dXDB+FdidFmew
         0IPI9zC4VvMQiGi56BbDyaP9fX/Ocg5NzpBWnUZuaDqOvjttlqwadnXsbKpcTQsmaFu6
         gyXtq5cYIwZ0R33rcp19TqrJBERXEI0+S7JRsvJIFlcWGHpr+RNsJYqzl62Otm1YIZmg
         Yao+l3roUOGtFNRaimFuzjtOfOzd5DyF/DlxwlaikoGE2jPGP1eSdMGqN3N1YKinSj6Z
         1IIg==
X-Forwarded-Encrypted: i=1; AJvYcCW5em5rVbyMh8tuOeAxoyZ+1MJu7163X8jkipWndlXDuX6aDhOrV5JKck1QrCisrWPR7vuYCuVET8KlCB28@vger.kernel.org, AJvYcCWo2LeqaDQXOTE+T0+WcY5XOXsgojmQ2LjewXzy4BSRkG7GC2QsmbN0ZJAZ07i/12CbKG5zmwvPcV/PAdrSW9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCtORqDbTQsndcv6u/6Amd1kROtTFjn/4kMM16Rc1ayTZlTAE
	6F5z6qKvaZQ0KyQ03QCRLmnwv0g/x68Wv3eiyAjEar9NCa034pnVjr5c+kF4Mvz/QZAlanLJo8Z
	J3g/yKm4PHIryAXJdwMJ/x2+ubxw=
X-Gm-Gg: ASbGncv+CuVEFtHT2nIIufvQ5339p+pgZSsiJ/NYD37dyyGFlQcIfOgYP4Gj4+dn0db
	3Buer53Uf6eYiZqI+HrW32S7zn/AWQRL1QDHrxKL/CXbcojZ13wVrlym0MIirN4GdRqRRo9S77Y
	ULt4c8wA==
X-Google-Smtp-Source: AGHT+IF0RS4ftxUi/5gsMlDTZ97MqhoilTR5nbgQvR9Hbq3pJnw0GQ+UCMGT6Y+mJn5iC29yoSvinQroVFNzfU+X1OE=
X-Received: by 2002:a17:907:9724:b0:ab7:851d:4718 with SMTP id
 a640c23a62f3a-abc09c27044mr1736963766b.36.1740446179223; Mon, 24 Feb 2025
 17:16:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6xjZhHxRp4Bu_SX@kspp> <Z69UdL9zaCINQSFC@cassiopeiae>
In-Reply-To: <Z69UdL9zaCINQSFC@cassiopeiae>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 25 Feb 2025 11:16:07 +1000
X-Gm-Features: AWEUYZmgRiwQFNtUHE3LYO3HnyBJ0zVgwbRvgZnt3tdjjXgXcXdwfVxCgBec9ww
Message-ID: <CAPM=9twgrjQdNCrnK2gXMckqDHRjBAwnCKx4HwAfty-Q6VZrig@mail.gmail.com>
Subject: Re: [PATCH][next] drm/nouveau: Avoid multiple -Wflex-array-member-not-at-end
 warnings
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Karol Herbst <kherbst@redhat.com>, 
	Lyude Paul <lyude@redhat.com>, Faith Ekstrand <faith.ekstrand@collabora.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Feb 2025 at 00:34, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Wed, Feb 12, 2025 at 07:31:26PM +1030, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> >
> > So, in order to avoid ending up with flexible-array members in the
> > middle of other structs, we use the `struct_group_tagged()` helper
> > to separate the flexible arrays from the rest of the members in the
> > flexible structures. We then use the newly created tagged `struct
> > nvif_ioctl_v0_hdr` and `struct nvif_ioctl_mthd_v0_hdr` to replace the
> > type of the objects causing trouble in multiple structures.
> >
> > We also want to ensure that when new members need to be added to the
> > flexible structures, they are always included within the newly created
> > tagged structs. For this, we use `static_assert()`. This ensures that the
> > memory layout for both the flexible structure and the new tagged struct
> > is the same after any changes.
> >
> > So, with these changes, fix the following warnings:
> > drivers/gpu/drm/nouveau/nvif/object.c:60:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > drivers/gpu/drm/nouveau/nvif/object.c:233:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > drivers/gpu/drm/nouveau/nvif/object.c:214:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > drivers/gpu/drm/nouveau/nvif/object.c:152:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > drivers/gpu/drm/nouveau/nvif/object.c:138:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > drivers/gpu/drm/nouveau/nvif/object.c:104:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > drivers/gpu/drm/nouveau/nouveau_svm.c:83:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > drivers/gpu/drm/nouveau/nouveau_svm.c:82:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> @Faith, Karol: Can I get an ACK from mesa for this one?

If we do reimport this to userspace we will have to figure it out, but for now,

Acked-by: Dave Airlie <airlied@redhat.com>

>
> > ---
> >  drivers/gpu/drm/nouveau/include/nvif/ioctl.h | 32 +++++++++++++-------
> >  drivers/gpu/drm/nouveau/nouveau_svm.c        |  4 +--
> >  drivers/gpu/drm/nouveau/nvif/object.c        | 12 ++++----
> >  3 files changed, 29 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/include/nvif/ioctl.h b/drivers/gpu/drm/nouveau/include/nvif/ioctl.h
> > index e825c8a1d9ca..00015412cb3e 100644
> > --- a/drivers/gpu/drm/nouveau/include/nvif/ioctl.h
> > +++ b/drivers/gpu/drm/nouveau/include/nvif/ioctl.h
> > @@ -3,25 +3,30 @@
> >  #define __NVIF_IOCTL_H__
> >
> >  struct nvif_ioctl_v0 {
> > -     __u8  version;
> > +     /* New members MUST be added within the struct_group() macro below. */
> > +     struct_group_tagged(nvif_ioctl_v0_hdr, __hdr,
> > +             __u8  version;
> >  #define NVIF_IOCTL_V0_SCLASS                                               0x01
> >  #define NVIF_IOCTL_V0_NEW                                                  0x02
> >  #define NVIF_IOCTL_V0_DEL                                                  0x03
> >  #define NVIF_IOCTL_V0_MTHD                                                 0x04
> >  #define NVIF_IOCTL_V0_MAP                                                  0x07
> >  #define NVIF_IOCTL_V0_UNMAP                                                0x08
> > -     __u8  type;
> > -     __u8  pad02[4];
> > +             __u8  type;
> > +             __u8  pad02[4];
> >  #define NVIF_IOCTL_V0_OWNER_NVIF                                           0x00
> >  #define NVIF_IOCTL_V0_OWNER_ANY                                            0xff
> > -     __u8  owner;
> > +             __u8  owner;
> >  #define NVIF_IOCTL_V0_ROUTE_NVIF                                           0x00
> >  #define NVIF_IOCTL_V0_ROUTE_HIDDEN                                         0xff
> > -     __u8  route;
> > -     __u64 token;
> > -     __u64 object;
> > +             __u8  route;
> > +             __u64 token;
> > +             __u64 object;
> > +     );
> >       __u8  data[];           /* ioctl data (below) */
> >  };
> > +static_assert(offsetof(struct nvif_ioctl_v0, data) == sizeof(struct nvif_ioctl_v0_hdr),
> > +           "struct member likely outside of struct_group()");
> >
> >  struct nvif_ioctl_sclass_v0 {
> >       /* nvif_ioctl ... */
> > @@ -51,12 +56,17 @@ struct nvif_ioctl_del {
> >  };
> >
> >  struct nvif_ioctl_mthd_v0 {
> > -     /* nvif_ioctl ... */
> > -     __u8  version;
> > -     __u8  method;
> > -     __u8  pad02[6];
> > +     /* New members MUST be added within the struct_group() macro below. */
> > +     struct_group_tagged(nvif_ioctl_mthd_v0_hdr, __hdr,
> > +             /* nvif_ioctl ... */
> > +             __u8  version;
> > +             __u8  method;
> > +             __u8  pad02[6];
> > +     );
> >       __u8  data[];           /* method data (class.h) */
> >  };
> > +static_assert(offsetof(struct nvif_ioctl_mthd_v0, data) == sizeof(struct nvif_ioctl_mthd_v0_hdr),
> > +           "struct member likely outside of struct_group()");
> >
> >  struct nvif_ioctl_map_v0 {
> >       /* nvif_ioctl ... */
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> > index b4da82ddbb6b..fc64c3d3169e 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> > @@ -79,8 +79,8 @@ struct nouveau_svm {
> >  #define SVM_ERR(s,f,a...) NV_WARN((s)->drm, "svm: "f"\n", ##a)
> >
> >  struct nouveau_pfnmap_args {
> > -     struct nvif_ioctl_v0 i;
> > -     struct nvif_ioctl_mthd_v0 m;
> > +     struct nvif_ioctl_v0_hdr i;
> > +     struct nvif_ioctl_mthd_v0_hdr m;
> >       struct nvif_vmm_pfnmap_v0 p;
> >  };
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvif/object.c b/drivers/gpu/drm/nouveau/nvif/object.c
> > index 0b87278ac0f8..70af63d70976 100644
> > --- a/drivers/gpu/drm/nouveau/nvif/object.c
> > +++ b/drivers/gpu/drm/nouveau/nvif/object.c
> > @@ -57,7 +57,7 @@ int
> >  nvif_object_sclass_get(struct nvif_object *object, struct nvif_sclass **psclass)
> >  {
> >       struct {
> > -             struct nvif_ioctl_v0 ioctl;
> > +             struct nvif_ioctl_v0_hdr ioctl;
> >               struct nvif_ioctl_sclass_v0 sclass;
> >       } *args = NULL;
> >       int ret, cnt = 0, i;
> > @@ -101,7 +101,7 @@ int
> >  nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
> >  {
> >       struct {
> > -             struct nvif_ioctl_v0 ioctl;
> > +             struct nvif_ioctl_v0_hdr ioctl;
> >               struct nvif_ioctl_mthd_v0 mthd;
> >       } *args;
> >       u32 args_size;
> > @@ -135,7 +135,7 @@ void
> >  nvif_object_unmap_handle(struct nvif_object *object)
> >  {
> >       struct {
> > -             struct nvif_ioctl_v0 ioctl;
> > +             struct nvif_ioctl_v0_hdr ioctl;
> >               struct nvif_ioctl_unmap unmap;
> >       } args = {
> >               .ioctl.type = NVIF_IOCTL_V0_UNMAP,
> > @@ -149,7 +149,7 @@ nvif_object_map_handle(struct nvif_object *object, void *argv, u32 argc,
> >                      u64 *handle, u64 *length)
> >  {
> >       struct {
> > -             struct nvif_ioctl_v0 ioctl;
> > +             struct nvif_ioctl_v0_hdr ioctl;
> >               struct nvif_ioctl_map_v0 map;
> >       } *args;
> >       u32 argn = sizeof(*args) + argc;
> > @@ -211,7 +211,7 @@ void
> >  nvif_object_dtor(struct nvif_object *object)
> >  {
> >       struct {
> > -             struct nvif_ioctl_v0 ioctl;
> > +             struct nvif_ioctl_v0_hdr ioctl;
> >               struct nvif_ioctl_del del;
> >       } args = {
> >               .ioctl.type = NVIF_IOCTL_V0_DEL,
> > @@ -230,7 +230,7 @@ nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
> >                s32 oclass, void *data, u32 size, struct nvif_object *object)
> >  {
> >       struct {
> > -             struct nvif_ioctl_v0 ioctl;
> > +             struct nvif_ioctl_v0_hdr ioctl;
> >               struct nvif_ioctl_new_v0 new;
> >       } *args;
> >       int ret = 0;
> > --
> > 2.43.0
> >
