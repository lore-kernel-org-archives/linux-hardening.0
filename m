Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE953D331A
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302610; cv=pass; b=YfrjdPRIlLyksOvtoyYiQw0a71t8Ck+4wi12jgHKPXu8gqqum1iYcP4HShBKZq2Y9J4APF9BFvzHNVEi4ec54ECPzld+uGutrxfn+iVeqkerxXrnOYyyvwHLZr8vQfoP+TvXlvclvYEyL9MXFBEGtC+WYJxf+k81dr3SFOIjWKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302610; c=relaxed/simple;
	bh=qc1VsHzsxRS/RqhD7Fa9PcGLrY6AMTUPRklAYrpkASc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kK4ELPGUbFm5zymNsEk9rs1k74P32bRzFbzlMYQtJy8oSGWec9TPZaWrqUCUgEZc4bb5TGHz0rEq76bVv0zhwWiaYi4l5+FCF3tVZzfe8DGm3Ua4LSstkCYvHpEkUfqZuqC0zeCvhUluJ5/m3IrygIPSwwnj3NwrnFELIpa99fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtURn8Ro; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtURn8Ro"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso113884866b.1
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 01:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787302606; cv=none;
        d=google.com; s=arc-20260327;
        b=E9M4elV8eQsbFLnTFOtKj3a4KJmjDDcJsU4hQrAj08N/+ARmdI3f0hxjb4qdlxO5wi
         BH4i7wP1tPS8gI/BOdS3JaEpL3M8Zgn8lvwQET6j3ybfcQHRN+mCkBmB9vIkHINamafr
         d8W2kNOKcdzSd4K+a3IhUWjXW/vMJNkdHLLP8gQoxhjNGA6PVwSKTFyjOqFS7LQzj+47
         NKl5J2E4ouM5ltH2V5uhoEZ7OKb2qpDvbgbnDSGyWVEh8yXP/avqEDa++tmPCZsQNZnc
         HzysXhc5JoQllitsbOtbWSORab97/9PVlUhnSRzFSNxW500nsttiRAVFnBBo4LldGWVu
         vC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qqXg1FfgN/C9CLoGqIFCehXKeWxjhCAjKa9HmGqcmYU=;
        fh=eAAFE/rCfPH1aN2csOrPZkC9XQ4fLdRdBXOLuC25Nz0=;
        b=QhcVHhpfCBwBvX3c0/wYaV33YjPK98Oii2sHyaivpJluwDiRN/LS/mb0tfc6D437FP
         uK66Oe2NZlKyYmVpHMY9UL8GjkYRqve0InQ7CgCN9ARMUU9A9tNhyapmextM8opYgTY5
         LCmFZnIZzuQhrw4DQBRfnlK/vnz74/1uMQQJi8dI63CzP7tTtVyridPXYekkK3Fshr8U
         5u7L1iEUWYUUg2jeu/xzZAz6gPkQ+D1u8UpR/05UdhxAQCAy1I0aFljaXa+YLzVw56Dy
         xlNMTq4m2c5CG77upMQ76dhwrpre3tjvdY3htGAn+F57TgOyg/ZN3/uuQEuhQfMLZd2r
         3skQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787302606; x=1787907406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qqXg1FfgN/C9CLoGqIFCehXKeWxjhCAjKa9HmGqcmYU=;
        b=NtURn8RoQhcH7Yz5lyRNEty9ER/O9KV8I222UGEW27xNjsDrAogPBJxn6W/DEuBPne
         QyBob+2VlvvmQLlP+Af7itA+rpf2W9QzQ6NWHNRRNZNO7WhHRAtTPwysCvx0U4JUgioJ
         TFxC4v3CUsZCHcMYpxGGFPXM601FC5r0W8gzhxT1ODUR0MW+PQPm+Kssa9/3ugGmZHxq
         ludYW/qOc+nUiyhY2CSi8VIu2bcguKFbxZQ0LdOQ0bnOcTsGoux99NnlEfGSBvjFx2S9
         kAQewZHwrrRXBV+ygIvt6NyVEm/9YlaWbX4xPN3a25GrDN8G/hfAwsDMR5SSLiGBzAw6
         +i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302606; x=1787907406;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqXg1FfgN/C9CLoGqIFCehXKeWxjhCAjKa9HmGqcmYU=;
        b=fhHKd+m7xGDC3CxesXVk7MW4YQSNkaVK2uyMvWaksAzybiId2Q+AcBNWJkhKthQM9X
         Ng8lMkg+4wvmGyvS9vLZFVY42oHAX7xXSYWwAWDowRhMfradHZUcLGBNlgToo88/01DT
         oahMkOgfh/CsoERW06e6iph5b+XxKcq4BsuF87Nk19yz4Iv088BFMcNAXJ98CzD4vQKx
         p/akMATF/8kNmboYt8sazN2KAoTkqEs14Or3PnPGZWew2bpAOE8MbluO1jMlXB1i+mt3
         GfS5cXcd9XIa2w2pnRmL3wsfU4GOq9Kvt0l8CFNxE6M8D0kmHDEx9q5OH84M/3rRgs+h
         8awA==
X-Forwarded-Encrypted: i=1; AHgh+RpXaj1/b7FhRa5BnDZhA+F7uiOChJ9C8CDgFXc49fIZy8RSCGUz8pOYnDRn0Z5KqRtmIf1SWudH+XK4WspPq6w=@vger.kernel.org
X-Gm-Message-State: AFuF++l4RLOwAyiBMTXEJDmp4wOH7ESuU5PVJNs4BRE2lttEhF+cyEd4
	Psu5rBvksGmgRQdjE3MkJd8RsI8LCX2JqGB5zRnSS6y+ycFmdgSHW9fFnxjprQ07RR0QvcWUGy1
	Sa8m5qwWDiUCZg98xdxKG/KGyruOAy5E=
X-Gm-Gg: AR+sD13y9cMp85hpQFzT85qHTj1fS9pVu+qnBoOsajWxZ65Db2p0eCKi8wpF/DvfJWn
	AWCJ9E7APbJf+gq927O8PoygU/lxM5A1iW/9GlPtdOltGhNxw7CvSK/CExYcZ0RnJzFHuvh8Ib/
	lcexeq6k1aI2hDUQ+b85CmT8l24hmpqIVe7dggpPSefP+n7U+18niEsWKoLh2EZRPYKLG28uQnX
	TbDwj1GRFVEeyOP75Cl1fW+2sScmQUpe8qsIX985LAkb3CWCa6sWkNDNQ2JVnUcj/dgimJJd4Br
	XGM2WdAC+VHyEWq9P75rAUVqAseFknfENyIWFuFYKjLuow==
X-Received: by 2002:a17:906:f049:b0:c16:126b:98b4 with SMTP id
 a640c23a62f3a-c246a2ef584mr482608866b.3.1787302606417; Fri, 21 Aug 2026
 01:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aojDH2Db6XIkVqcf@kspp>
In-Reply-To: <aojDH2Db6XIkVqcf@kspp>
From: Richard Biener <richard.guenther@gmail.com>
Date: Fri, 21 Aug 2026 10:56:34 +0200
X-Gm-Features: AcwNN1XngggQNdw40tLAAYkITjX2XC-vj2xIg7UOrPXcp1qabsU_qHZqsR_j7_Y
Message-ID: <CAFiYyc2Uhw0iCwfmCET7gWLnXXYeV7wwPJv9Ny0uEcOrYA2f4A@mail.gmail.com>
Subject: Re: [PATCH] tree-object-size: Fix type-1 size for pointers to
 FAM-containing subobjects [PR126975]
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jakub Jelinek <jakub@redhat.com>, Siddhesh Poyarekar <siddhesh@gotplt.org>, Kees Cook <kees@kernel.org>, 
	gcc-patches@gcc.gnu.org, Martin Uecker <uecker@tugraz.at>, josmyers@redhat.com, 
	Bill Wendling <morbo@google.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:30=E2=80=AFAM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> For a pointer to a subobject whose record/union type ends in a flexible-a=
rray
> member (directly, or through its trailing nested struct), addr_object_siz=
e()
> walked up to the enclosing object (v =3D TREE_OPERAND (v, 0)) instead of
> measuring the referenced subobject. __builtin_object_size() and
> __builtin_dynamic_object_size() type 1 therefore returned the whole-objec=
t
> size, collapsing type 1 onto type 0 and losing the distinction between
> &p->inner and p. FORTIFY_SOURCE relies on the type-1 distinction, so this
> weakens its bounds checks.
>
> Fix this by computing the size directly from the referenced record/union
> instead of walking up, restoring the type-0/type-1 distinction that Clang
> already implements.
>
> Bootstraped and regtested on x86_64-linux-gnu.
>
>         PR tree-optimization/126975
>
> gcc/ChangeLog:
>
>         * tree-object-size.cc (addr_object_size): For a reference to a
>         record or union type, compute the object size from the referenced
>         subobject instead of walking up to the enclosing object when the
>         type recursively includes a flexible array member.
>
> gcc/testsuite/ChangeLog:
>
>         * gcc.dg/builtin-object-size-pr101832.c (main): Update the expect=
ed
>         results of __builtin_object_size (..., 1) queries on subobjects
>         whose type contains a flexible array member.
> ---
>  .../gcc.dg/builtin-object-size-pr101832.c      |  6 +++---
>  gcc/tree-object-size.cc                        | 18 +++++-------------
>  2 files changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c b/gcc/te=
stsuite/gcc.dg/builtin-object-size-pr101832.c
> index 60078e11634..d76286ae454 100644
> --- a/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
> +++ b/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
> @@ -92,9 +92,9 @@ int main (int argc, char *argv[])
>    outer =3D (void *)magic1;
>    outest =3D (void *)magic2;
>
> -  expect (__builtin_object_size (&outer->a, 1), -1);
> -  expect (__builtin_object_size (&outest->b, 1), -1);
> -  expect (__builtin_object_size (&outest->b.a, 1), -1);
> +  expect (__builtin_object_size (&outer->a, 1), sizeof(outer->a));

I think this warrants updating the documentation in extend.texi where
I think the
question is how for

struct A {
  int n;
  char data[];
};

struct B {
  int m;
  struct A a;
};

structr B *outer;

and object &outer->a, how, based on 'type', the enclosing object
size is constrained by its enclosing object.  Also for outer->a.data
what the enclosing object is and similar how the constraint from the
enclosing objects are handled.

I'll note that __builtin_object_size behavior might be in conflict
with constraints set by -fstrict-flex-arrays.  IIRC "nested" flex arrays
are a GNU extension, flex arrays not at the end of an (enclusing)
object as well (a particularly bad one).

You also need to update the toplevel comment of the testcase
which explicitly says your change is wrong.

> +  expect (__builtin_object_size (&outest->b, 1), sizeof(outest->b));
> +  expect (__builtin_object_size (&outest->b.a, 1), sizeof(outest->b.a));
>
>    struct B0 *outer0;
>    struct C0 *outest0;
> diff --git a/gcc/tree-object-size.cc b/gcc/tree-object-size.cc
> index 54c320d36d0..5c8b4ee7862 100644
> --- a/gcc/tree-object-size.cc
> +++ b/gcc/tree-object-size.cc
> @@ -732,21 +732,13 @@ addr_object_size (struct object_size_info *osi, con=
st_tree ptr,
>                         v =3D NULL_TREE;
>                         break;
>                       }
> -                   /* if the ref is to a record or union type, but the t=
ype
> -                      does not include a flexible array recursively, com=
pute
> -                      the object size directly.  */
> +                   /* If the ref is to a record or union type, compute t=
he
> +                      object size directly, regardless of whether the ty=
pe
> +                      recursively includes a flexible array member.  */
>                     if (RECORD_OR_UNION_TYPE_P (TREE_TYPE (v)))
>                       {
> -                       if (!TYPE_INCLUDES_FLEXARRAY (TREE_TYPE (v)))
> -                         {
> -                           v =3D NULL_TREE;
> -                           break;
> -                         }
> -                       else
> -                         {
> -                           v =3D TREE_OPERAND (v, 0);
> -                           break;
> -                         }
> +                       v =3D NULL_TREE;
> +                       break;
>                       }
>                     /* Now the ref is to an array type.  */
>                     gcc_assert (TREE_CODE (TREE_TYPE (v)) =3D=3D ARRAY_TY=
PE);
> --
> 2.47.3
>
