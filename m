Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288430DD00
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228813; cv=pass; b=f9yV3Ygc8PlSe7msCe+3qz9iBg+k3cQSiQ8tkaMZxdIDLYsa5/R4nELeEDt8/kdMGunWydSrq6wC5DNKejs3/u56hY8jAWZncXdPnZsBk0fLFISwVMGGv1f3LHIpmQ6mc94Gb2vpDJnWo3F8sn4DANgc7nJrm1LB0Ey0RUMgfa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228813; c=relaxed/simple;
	bh=jsLpsyC+KaNvNvqB9CLckEKnWKLK5lRXm5n/C+GqoYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1b5TZaBoVJKbE/0Wv5CT7+smzRnYePVdaeMvbZ+S+PojmQesQTVraVMeiZ9E1jkuQHEW8KJLAROeZsIxLvjcPqCv3dAmZa9r7JqtTXgX+UoNlGBSU3rtQAiZqBA5aBGAqdNvAkR170wilHBndsG5AWEeVzRsR+BBJVjks2klIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUtjYobt; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUtjYobt"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-74ab6c88052so1263107137.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 12:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791228811; cv=none;
        d=google.com; s=arc-20260327;
        b=Asqzg3Elg+1dIJ26kRSDLFlBE6GdUt84auBozW5pwFF9T9E8cwnYNB6SoWwqx9gEHK
         /4AeX1uBBmynG/3C5h/Btr2fvNyqLZwFCNNO5omRgKfENi/GY4RhD6PyYjvoSoEsY8XE
         wrc+/VLOP0suKuRL7By6KbKsMsLNKKCqJO/qfBWFFIOESLmaWRoF6R/si7m5k1Nb49he
         jk9J9FQ3EsDF7H1ugfcLd7q+f3EoTiorZUT1u+wI7cnIzaA6QtGcdFu/mcG0l9A3inwZ
         Ej1882WRDDU/f2a9vRnhOSyDRfvmybKiZ56203KaSK5thi0C3mB9pj0uEc/Pw/3QlLb7
         m92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+lWtKVXMW2++bit7wvkgTZ38ocIpzbCdiXdguzjZOQY=;
        fh=dlCbEIv9/+iU8flMCN6EgQnGl1/QIztaVPIF6A9NKhk=;
        b=GQBGil/c5FKf4ZfeRpXMGS1aGhsAuYfGWrgig+unBGSnJmsSXjrIygt2pLjmfW2Mc1
         Ip/3ZCsnoFskYU9TUhmWQxDazL9uWvg03m85WCaNPJe9HID61zLBt0/BQXI/IxowKb2n
         TWHMwZN7DrXLOvy9MEgt84XReJpOY1H8AqreRS6RzLWAa+VWeFJ+0zkUcgRGqyvSRwCW
         RD5Gtq1A73gV4RRVrCIIn9x1L1pMXroLl/dVFKCqRkGP/4pWqRjS7t0OHhLKV7a9/QrP
         nUrC2brNC/7VxuRg3NEtHDo+Rgdy0aAE1ovpFsU5cOVKcb8sW8pIHqVeyGu/M+Jze/lM
         eCYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791228811; x=1791833611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+lWtKVXMW2++bit7wvkgTZ38ocIpzbCdiXdguzjZOQY=;
        b=dUtjYobtufLPMhmG2rDtmGsQPayGA+L1glKWeIwFTLtufv0wO00MBuc7bT6ZlVg81t
         0wWnEe5TLaduRNYup36ugDEwSeOSTfLYHAWmMK5cRq8fJlCgq9U6dDGpx4EKh6Ubgbnn
         FS7VzromC13+fsPtSd4Bxztbx3e4/sUyJ1I9SSoRag9QRGX0zQlxjcn3MQAskjoHGBq5
         hm9pUAid4CPuzKm29jFl1HwoXEKqzjO7V7mCra6spWpdta1hNg789VMY1IXWzuoosQ08
         vZNDBzD4YkvNsN7H3OiGOxyDMkwDVJkiHD8yVGjhP/elrVE5epljq39C5xZCxBHkQ2F3
         /pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791228811; x=1791833611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+lWtKVXMW2++bit7wvkgTZ38ocIpzbCdiXdguzjZOQY=;
        b=wjm7b2hTHNwGqz1AQ/gwqwP72bWNQzt1ofWYtFyOmpejE+LyvYtrYDKBxu77pEdw3j
         eYIPeWMj5/FUBNOMhvZz5UCScZAhtFHA04iBUBAsCzfxVnEh7gT/a+gPnMDRKSfLsAzD
         7+eBmw6PkIimcgOvsezQvbn0fgMbwpl1xgTaMfAAwF8v2bEnJ5EZRVNCiIEDcD/HzXIP
         SG6TglCSd/Ck3aiqYluEY3n7VSpIBWV4x3TRUb/epTPC5mM0ksWDGxlGA/N5a6JJLX26
         z+c/Lm8Ml/7CjdsvV23SKib+tqItE4j9daOk6I0H75/pUQyFu0SD98BLwnSqCMQRpl9N
         EoIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYjTRCAHl89jb4J1SeF+eCfGRD5g0ZCCM5IifEzPrMOuhvc9Phgh+zNTMu85DqteoMllP8zhTp6PWzCOAnMM8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIFa67d/JLVHiKJs2dUDJreD0GOC8lcCGNhGjfVVVsyxhi8FgH
	IewMHRgIH5IsWnE0dG/0bFn52MvBvP72yv7LSUGt2AlIgSIGv+QZdM65oj2UoR50dNGnC2YqKVN
	JwQJ9wtMNyQ3Yh2XC+DDLbfOSpAlS5yLK87Y5pWg=
X-Gm-Gg: AYBFou0CxyTHRUSmzyEqUdLcUD7Ya6n/yaOfWR0sCWGEGw8c6Wakg9f6yeEKb4Y1mLj
	/h1z5Em0uuI+KskitgO7YyIo0iK3F0Bgk+euoUIb5M3I68Pg7OJLKe+FSt9g2IOgCpF9kL712nQ
	tFC5QOYqnHGv93sHBZLUxNn9Qpb5SAD2vQeQnkG9YMW9Pq5UXhAgW3dTdzjtUSf4UhbizxBfzpC
	k2HbJP0a2HrBMqxMoIa82tvg6c80s1ZGOq2pQ9mr23RS7BptyD8h7RsVUYoH6Eua5ooaIcGio9S
	o5aqUv6hMc6Sdn/kPLK9FK9iQmN6IEjfX9YPD+1v0rWEspbJfoO/kJhcIBRYtB71ii6Cj845caA
	nSDgBH5YHmE4lIiqGmhjpr6mw+HM8ds9CxmCE+RAomquIKmLpLxpO
X-Received: by 2002:a05:6102:4494:b0:7c3:7ce9:4382 with SMTP id
 ada2fe7eead31-7c37ce9454dmr1299257137.23.1791228809910; Mon, 05 Oct 2026
 12:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925204423.80661-1-morbo@google.com> <605221ed-a1b5-4179-be8d-b206c79487d7@intel.com>
 <CAGG=3QWoa0sK1P2VEAW+76EkFsjzXEZ9ucJg4iiOv29i8Sgzxw@mail.gmail.com> <8093ecff-842a-4063-bb29-4eb4903f7f73@intel.com>
In-Reply-To: <8093ecff-842a-4063-bb29-4eb4903f7f73@intel.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 5 Oct 2026 12:33:13 -0700
X-Gm-Features: AclHuK-08Gp8lXrK0ezKgiJftqCSrSRzq-iRMR2siWd-Z9YgizK2rcJ2TL6POD4
Message-ID: <CAGG=3QVooPkjbNi10D7MwN7WHgyhHderziJzdmEet5ne6dPQSA@mail.gmail.com>
Subject: Re: [PATCH] gpu/buddy: add __counted_by_ptr attribute to roots
To: Matthew Auld <matthew.auld@intel.com>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 1:36=E2=80=AFAM Matthew Auld <matthew.auld@intel.co=
m> wrote:
> On 28/09/2026 19:44, Bill Wendling wrote:
> > On Mon, Sep 28, 2026 at 5:20=E2=80=AFAM Matthew Auld <matthew.auld@inte=
l.com> wrote:
> >>
> >> On 25/09/2026 21:44, Bill Wendling wrote:
> >>> In 'struct gpu_buddy', the 'roots' field points to an array of pointe=
rs
> >>> to 'struct gpu_buddy_block'. The number of allocated roots is tracked
> >>> by the 'n_roots' field.
> >>>
> >>> Annotate the 'roots' pointer with the '__counted_by_ptr' attribute
> >>> referencing 'n_roots' to enable compile-time and runtime bounds-check=
ing
> >>> via KASAN and '__builtin_dynamic_object_size'.
> >>>
> >>> In 'gpu_buddy_init', 'mm->n_roots' is initialized first, and 'mm->roo=
ts' is
> >>> subsequently allocated with 'kmalloc_objs(struct gpu_buddy_block *,
> >>> mm->n_roots)'.
> >>>
> >>> Since the bounds associated with 'roots' ('n_roots') are fully set pr=
ior
> >>> to any array allocation or access and remain invariant, this annotati=
on
> >>> will not cause runtime panics or false-positive bounds checks.
> >>>
> >>> Cc: codemender-patching+linux@google.com
> >>> Assisted-by: LLM
> >>> Signed-off-by: Bill Wendling <morbo@google.com>
> >>
> >> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> >>
> >> Would it make sense to also do this for *_scoreboard and free_tree, if
> >> we add a new field n_orders?
> >>
> > Sure! There's already a 'max_order'. I assume that 'n_orders' would be
> > more dynamic?
>
> Yeah, I think just mm.n_orders =3D max_order + 1. I assume the
> __counted_by_ptr() only works with a field?
>
Well, yes*.

* The original Clang design of __counted_by (and associated)
attributes accepted context-free expressions. However, GCC isn't able
to handle expressions and we weren't able to agree on a syntax that
was acceptable to both compiler teams. Thus, we won't be supporting
expressions in these attributes, unless something miraculous happens.

-bw

> >
> > -bw
> >
> >>> ---
> >>>    include/linux/gpu_buddy.h | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> >>> index 2c36124bb696..d7249e500ab6 100644
> >>> --- a/include/linux/gpu_buddy.h
> >>> +++ b/include/linux/gpu_buddy.h
> >>> @@ -172,7 +172,7 @@ struct gpu_buddy {
> >>>         * a power of two, with each root being the largest power-of-t=
wo
> >>>         * that fits in the remaining space.
> >>>         */
> >>> -     struct gpu_buddy_block **roots;
> >>> +     struct gpu_buddy_block **roots __counted_by_ptr(n_roots);
> >>>        /*
> >>>         * Per-order free block scoreboard: free_scoreboard[order] hol=
ds the
> >>>         * number of blocks of that order currently in the free state.
> >>
>
