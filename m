Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197A46D08F
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662791; cv=none; b=Ea+2pndd4XblQuZWep9B5J7Hp6AICov53mEJ2SXso8elnytDJVxWDNwKfwLCrnUUj+wDdLXodb1fOYmIG+1nOAMKyi5vebFd5Jsthn6ll1MVwYdqGwcn9pkAL66XYdPifTg2q69M7s/BgJVK8Rf3aSfZlarJSFv0CyFJ407gY00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662791; c=relaxed/simple;
	bh=F6OcaLKcmSxKbgrBqNHVobDtHy0slrK/ALAX1uSyMeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8iBtPtWv8AGesfroZd3p4L1xAgGjoWdfCj2j9lgaj14S4BcmnzL7ob6KE4l+oVuWBfbZXO4ZurHA0sJh0HpCqmBw7EyUxfxDq4bRKXzImZmDqHbIH6E0WMeiBAt7urdW7mcmcLjiaqsrtaINiXkFfMCEGWEuhT6XXel80N1yjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdZNdFVt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdZNdFVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784662788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCe9qOTJlyreKg3yvC+TlYK8FC5b0E2L6RBPi06mQbo=;
	b=BdZNdFVtexDRjmQqkKKFJYfmMxMNRaWLFyqU7k8iJj6yCamwZvmIUsudEWR+I/FRnQSvlo
	1K5w5DEaNmS3PBni8Fsq7GsCO/CJDFVvcBl2P5klyPkuZlbD09/g4bZIrcEkFso4ZSiBoC
	TNGaSDDKqF7/VVH370mvfAGSbDsPWbk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-5r81oog-NxaA7Z0jBXvIjA-1; Tue, 21 Jul 2026 15:39:45 -0400
X-MC-Unique: 5r81oog-NxaA7Z0jBXvIjA-1
X-Mimecast-MFC-AGG-ID: 5r81oog-NxaA7Z0jBXvIjA_1784662784
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f83a59e5aso466165f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 12:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662784; x=1785267584;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCe9qOTJlyreKg3yvC+TlYK8FC5b0E2L6RBPi06mQbo=;
        b=me/lrXr+W2O/y+pkdw1a6QXMUUfJVAtM56ibrVF6/Lt7MaLWd4d+OBxiCmiNgoXjl/
         ptJhgY/U1NDk9s7C8to3OQwyC10szNTlKJmnKmPiV6KV3MwPKCJ/NE/LFJMbVtxApsCc
         I+st2cJ4XMUUCxd+n3zgKwlNx9RhG9XHUc/k6wY8+LLl/pvunTQSJx3ISV3PGDCxjKOI
         ns40N5zilA6PxBsvJSNSndQCU3a9yLzSw1GC6ekrsl0kmkL6aErGTFRlgQB7OlNZdBsW
         5K17Qs8u35ZsyZDj6eaAgPgJaM0rEv4Vmwz/Im0u6QUi0oKSrRYeDmjjY47QykO9I+SB
         FOXw==
X-Forwarded-Encrypted: i=1; AHgh+Rpl+EpCtz/0T7NV60ha2RIIr17DnJFsOy42+hL74pbePs8yQC/RAOh47h4U6NHdLVFDD81kmPRUb+IHNgbwLfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZW+vqC2RF+7VhdRnHjtXBC9cHjDWu5XYOSlBTZvPSqQXfSu5
	MTWW6i5jWIiFrhJ3/SBUBgPASjSH/yMssBj7uwNRuLmkuMOnVHbEiqGfj2ERuFhJPTjgOhvXj8e
	yEV5MRkp9ST6+7LoNYlEvHjW4p4UVmDgKdpKqh6nud9ZLACwGtC1bsM5nBAGcqm/eZu0fRb1CuI
	RIjPnkU2VE1BYE+YkzISS+06fur3I8PXvW/1SIqeoCu0aJ
X-Gm-Gg: AR+sD12CMMF1DRqKofI24RnzNHUwevOyoAgI4XYr8Sej25UQ8trx6EZfomdCRQNApJd
	Lp7nY5lyuyRDFefTRpj5Ms/e80zDAIe/NnvhseyAnP5SStw1Al/XvnDuULWunxIeMIf3enX/vJg
	oLsKRwCeuyNGKzpLP3l6yHt01FlO5EG3XQi0DI0aEBrPBfSyzy6fipm3BKs5uA4iWGg94WtmbSg
	oC5pbf+1clzJdE=
X-Received: by 2002:a05:6000:3105:b0:47f:853d:4768 with SMTP id ffacd0b85a97d-47f853d491bmr65311f8f.20.1784662783837;
        Tue, 21 Jul 2026 12:39:43 -0700 (PDT)
X-Received: by 2002:a05:6000:3105:b0:47f:853d:4768 with SMTP id
 ffacd0b85a97d-47f853d491bmr65275f8f.20.1784662783279; Tue, 21 Jul 2026
 12:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714151818.538869-1-jtaubepe@redhat.com> <202607150906.33F01B40@keescook>
 <CADRr4bfXHAHhOwnxaFFTJ7CWFE6PAReqnCWPAqQQuPAmU3d-SA@mail.gmail.com> <838b5a6c-aecb-4ab7-9aea-b329b16a6acf@embeddedor.com>
In-Reply-To: <838b5a6c-aecb-4ab7-9aea-b329b16a6acf@embeddedor.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Tue, 21 Jul 2026 15:39:28 -0400
X-Gm-Features: AUfX_mweGGSykwHDE5Btqxj9naJj7ujm6oWqjySDS_axZkTrH9ZcixFm5yhuL4g
Message-ID: <CADRr4bfDcJX7o6eVrrEG-wSX=Uivam6gOvrnUuRF+u+mEsmwQA@mail.gmail.com>
Subject: Re: [RFC PATCH] overflow: Add DECLARE_SIZED_FLEX() helper family
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Christoph Hellwig <hch@infradead.org>, John Meneghini <jmeneghi@redhat.com>, Chris Leech <cleech@redhat.com>, 
	Jesse Taube <mr.bossman075@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N3ODIuQHUKwh8dRAljpdqmjtWKXLVf2SLAZVXMwFAk8_1784662784
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 4:19=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi!
>
> On 7/17/26 10:17, Jesse Taube wrote:
> > On Wed, Jul 15, 2026 at 12:12=E2=80=AFPM Kees Cook <kees@kernel.org> wr=
ote:
> >>
> >> On Tue, Jul 14, 2026 at 11:18:18AM -0400, Jesse Taube wrote:
> >>> Add new DECLARE_SIZED_FLEX() helper to set the default size of a
> >>> flexible-array member. The code is identical to the declaration in
> >>> __DEFINE_FLEX() which has also been changed to use DECLARE_SIZED_FLEX=
().
> >>>
> >>> Add DECLARE_COUNTED_FLEX_ARRAY() helper which is a variant of
> >>> DECLARE_FLEX_ARRAY() with a counted-by attribute.
> >>>
> >>> Also add default sized variants of
> >>> DECLARE_FLEX_ARRAY(), DECLARE_SIZED_FLEX(), and
> >>> DECLARE_COUNTED_FLEX_ARRAY(), DECLARE_COUNTED_SIZED_FLEX().
> >>
> >> Where do you want to use these new helpers?
> >>
> >>> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> >>> ---
> >>>   include/linux/overflow.h | 58 +++++++++++++++++++++++++++++++++++++=
---
> >>>   1 file changed, 54 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> >>> index a8cb6319b4fb..a3384cae49e5 100644
> >>> --- a/include/linux/overflow.h
> >>> +++ b/include/linux/overflow.h
> >>> @@ -464,6 +464,59 @@ static __always_inline size_t __must_check size_=
sub(size_t minuend, size_t subtr
> >>>    */
> >>>   #define struct_offset(p, member) (offsetof(typeof(*(p)), member))
> >>>
> >>> +/**
> >>> + * __DECLARE_SIZED_FLEX() - helper macro for DECLARE_SIZED_FLEX() fa=
mily.
> >>> + * Allows for easily declaring a structure with a trailing flexible =
array member
> >>> + * to have a specific size.
> >>> + *
> >>> + * @obj: object to be given a specific size
> >>> + * @name: Name of the array member.
> >>> + * @count: Number of elements in the array; must be compile-time con=
st.
> >>> + */
> >>> +#define __DECLARE_SIZED_FLEX(obj, name, count)       \
> >>> +     _Static_assert(__builtin_constant_p(count),             \
> >>> +                    "default sized flex array members require compil=
e-time const count");    \
> >>> +     union {                                                 \
> >>> +             u8 bytes[struct_size_t(obj, name, count)];      \
> >>> +             obj;                                            \
> >>> +     }
> >>> +
> >>> +/**
> >>> + * DECLARE_COUNTED_FLEX_ARRAY() - Declare a counted flexible array
> >>> + *
> >>> + * @type: Type name.
> >>> + * @name: Name of the array member.
> >>> + * @counter: Name of the __counted_by member.
> >>> + */
> >>> +#define DECLARE_COUNTED_FLEX_ARRAY(type, name, counter)\
> >>> +     struct { \
> >>> +             size_t counter; \
> >>> +             type name[] __counted_by(counter); \
> >>> +     }
> >>> +
> >>> +/**
> >>> + * DECLARE_SIZED_FLEX() - Declare a structure with a trailing flexib=
le array
> >>> + * member with a default size.
> >>> + *
> >>> + * @type: Type name.
> >>> + * @name: Name of the array member.
> >>> + * @count: Number of elements in the array; must be compile-time con=
st.
> >>> + */
> >>> +#define DECLARE_SIZED_FLEX(type, name, count)        \
> >>> +     __DECLARE_SIZED_FLEX(type name[], name, count)
> >>> +
> >>> +/**
> >>> + * DECLARE_COUNTED_SIZED_FLEX() - Declare a structure with a trailin=
g flexible
> >>> + * array member counted by count, with a default size.
> >>> + *
> >>> + * @type: Type name.
> >>> + * @name: Name of the array member.
> >>> + * @counter: Name of the __counted_by member.
> >>> + * @count: Number of elements in the array; must be compile-time con=
st.
> >>> + */
> >>> +#define DECLARE_COUNTED_SIZED_FLEX(type, name, counter, count)      =
 \
> >>> +     __DECLARE_SIZED_FLEX(DECLARE_COUNTED_FLEX_ARRAY(type, name, cou=
nter), name, count)
> >>
> >> I ask about where these will be used because one of the things I want =
to
> >> keep tied together is the "counter" and "count", which usually means t=
he
> >> declaration should be combined with an initializer in some way so that
> >> the counter gets assigned, as DEFINE_FLEX() ultimately does.
> >>
> >> I'm worried that extracting the internal construction of __DEFINE_FLEX
> >> means we may run the risk of increasing the risk of losing that tie.
> >
> > We can add a comment to make sure to set count, or use DEFINE_FLEX
> > to allocate it. Im not sure if there is a way for this to be a compile =
time
> > error though.
> >
> >> So, I'd love to understand how you want to use this, as that would hel=
p
> >> my understanding and potentially shape the design so we can keep count=
er
> >> and count strongly associated.
> >
> > Basically, I want to use `DECLARE_COUNTED_SIZED_FLEX` for a version of
> > this patch that
> > uses `__counted_by`
> > https://lore.kernel.org/linux-scsi/97526d45-ec7d-48a0-bdc6-659f75839f53=
@embeddedor.com/
> > I have checked that it does always set the `counter` variable correctly=
.
> >
> > As for `DECLARE_COUNTED_FLEX_ARRAY` there is already `DECLARE_FLEX_ARRA=
Y` and
> > the counted variant is already used in a few places. A good example is
> > `struct max77759_maxq_response` which subsiqently gets allocated with
> > `DEFINE_FLEX`
> > https://elixir.bootlin.com/linux/v7.2-rc1/source/include/linux/mfd/max7=
7759.h#L253
> >
> > I assume you are ok with adding `__DECLARE_SIZED_FLEX` and
> > `DECLARE_SIZED_FLEX` as
> > they are usefull in cases where keeping structure offsets is
> > important, similar to
> > TRAILING_OVERLAP. An example of where `__DECLARE_SIZED_FLEX` could be u=
sed is:
> > https://lore.kernel.org/all/20260714185621.610105-1-jtaubepe@redhat.com=
/
>
> Please show us examples of how exactly you'd use the helpers you propose
> for the cases you mentioned above.


Sorry for the late reply.

Here is an example of DECLARE_COUNTED_FLEX_ARRAY,
I notice now that the macro should be passed the count variable's type
and not have it as size_t.
```c
+++ b/drivers/net/wireless/ath/ath10k/bmi.h
@@ -136,21 +136,12 @@ struct bmi_cmd {
                struct {
                        __le32 patch_id;
                } rompatch_uninstall;
-               struct {
-                       __le32 count;
-                       __le32 patch_ids[]; /* length of @count */
-               } rompatch_activate;
-               struct {
-                       __le32 count;
-                       __le32 patch_ids[]; /* length of @count */
-               } rompatch_deactivate;
+               DECLARE_COUNTED_FLEX_ARRAY(__le32, patch_ids, count)
rompatch_activate;
+               DECLARE_COUNTED_FLEX_ARRAY(__le32, patch_ids, count)
rompatch_deactivate;
                struct {
                        __le32 addr;
                } lz_start;
-               struct {
-                       __le32 len; /* max BMI_MAX_DATA_SIZE */
-                       u8 payload[]; /* length of @len */
-               } lz_data;
+               DECLARE_COUNTED_FLEX_ARRAY(u8, payload, len) lz_data;
                struct {
                        u8 name[BMI_NVRAM_SEG_NAME_SZ];
                } nvram_process;
```

Here is where i want to use DECLARE_COUNTED_SIZED_FLEX, it would fix the
"memcpy: detected field-spanning write (size 60) of single field".
It seems like the only two places where a structure like this occurs is in
qla2xxx and qla4xxx
https://lore.kernel.org/linux-scsi/20250813200744.17975-10-bgurney@redhat.c=
om/
```c
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.=
h
index 5593ad7fad27..7241cf6e6c7e 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4912,10 +4912,7 @@ struct purex_item {
        void (*process_item)(struct scsi_qla_host *vha,
                             struct purex_item *pkt);
        atomic_t in_use;
-       uint16_t size;
-       struct {
-               uint8_t iocb[64];
-       } iocb;
+       DECLARE_COUNTED_SIZED_FLEX(uint8_t, iocb, size, 64);
 };
```

Here is an example of DECLARE_SIZED_FLEX:
```c
#define DEFUALT_SIZE 64

struct flex_array {
int some_element;
DECLARE_SIZED_FLEX(uint8_t, payload, DEFUALT_SIZE);
};

struct struct_with_flex_array {
int some_element;
struct flex_array flex_array;
};

int main() {
struct struct_with_flex_array my_struct;
struct flex_array *my_struct2;
uint8_t big_payload[100] =3D {};

/* Size of struct_with_flex_array: 72*/
printf("Size of struct_with_flex_array: %zu\n", sizeof(my_struct));
/* kzalloc_flex would need the size to be (sizeof(big_payload) -
DEFUALT_SIZE) */
my_struct2 =3D kzalloc(sizeof(*my_struct2) + sizeof(big_payload) -
DEFUALT_SIZE, GFP_KERNEL);

/* Size of allocated flex_array: 104 */
printf("Size of allocated flex_array: %zu\n", sizeof(*my_struct2) +
sizeof(big_payload) - DEFUALT_SIZE);

/* Avoids "memcpy: detected field-spanning write (size 100) of single field=
" */
memcpy(my_struct.flex_array.payload, big_payload, sizeof(big_payload));
return 0;
}
```

Thanks,
Jesse Taube


>
> Thanks
> -Gustavo
>
> >
> > Thanks,
> > Jesse Taube
> >
> >>
> >>> +
> >>>   /**
> >>>    * __DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
> >>>    * Enables caller macro to pass arbitrary trailing expressions
> >>> @@ -477,10 +530,7 @@ static __always_inline size_t __must_check size_=
sub(size_t minuend, size_t subtr
> >>>   #define __DEFINE_FLEX(type, name, member, count, trailer...)       =
          \
> >>>        _Static_assert(__builtin_constant_p(count),                   =
          \
> >>>                       "onstack flex array members require compile-tim=
e const count"); \
> >>> -     union {                                                        =
         \
> >>> -             u8 bytes[struct_size_t(type, member, count)];          =
         \
> >>> -             type obj;                                              =
         \
> >>> -     } name##_u trailer;                                            =
         \
> >>> +     __DECLARE_SIZED_FLEX(type obj, member, count) name##_u trailer;=
         \
> >>>        type *name =3D (type *)&name##_u
> >>
> >> -Kees
> >>
> >> --
> >> Kees Cook
> >>
> >
>

