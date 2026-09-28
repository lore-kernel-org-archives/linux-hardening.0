Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C13845D3
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621096; cv=pass; b=bvPR24QqUT7s2E5TrhwueA2foaqcVQb3owZ/NzS2VnqSfHrqJIbit5oClU9uc9r2FpLVjZYdMjorzDS2cvnPxHjLb7fImxx/NhUT59GbY3wuPYOR2Eyd5Lv0YWRmwDwMvxGmJ52eY5yXeWeJ76kW65xejFLSS5XIfkTCoBpYpxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621096; c=relaxed/simple;
	bh=XbAAAKuCIZsrCvYM1W9GX9bz0Evcj+nhL3IrdoI29kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AatOYjjjeOafh0cximXIQMxt+pOnLDpiA9WH2/Q0OxKNqCgNyS4ev1wnPhfPSgQIj/jnwHCr3i6tGleb+tX+bEwDoulTe7FyXpjPTHWbCSDXhNmt3TIT5HfLwuVHYsT7IvjouhTF2ab5AxByo1JUHWXbJhl2AoEL/Zfh/yzalek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVM2gbMd; arc=pass smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVM2gbMd"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5cca96ec1feso961734e0c.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 11:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621093; cv=none;
        d=google.com; s=arc-20260327;
        b=GTGiNyPiwC37axB0JEej2/OXOyB0cq3isMTmQugSH1/OeDCEZ4/vIzAMlZ5zIKg1g8
         vooPkIbTgxcUfaIJpyHNxaT3unv1rOeHZDWIg+cRzAN5NV/bF2E2g67W5WLLCI2d8uxu
         EqCe4BzM8cGwwYFfI+uSuA/6rMd7Ngcdr1MtmYRsTIgGnkjRsk3xebaMbDtDMxvpLgff
         JcJqcXS3cxG3wFVE2HpmlhZyo2g3r8Yynas+7bMpwKUGSSNJvV2JdZSLHFcAF96JmwMy
         OaTM6ihatbmgVssLMBE4n7zvqwpzmeVtcJLhdAENG4vvcJWyaarYJBq9Wk6n/xe56gMa
         nRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9MUoqVvpT69Aq5ZarehzNgWsu7OePV3YFvLIai8Gmus=;
        fh=4TbeHZOL5zr9bwT9HGPzqhmwnJAPR/amKrxv+s1d1LE=;
        b=Ccp60CaFx+EI+M2TwgRpw3tlxBKTN0XTj5Bzzm7KY2ubkiAOD+0fMp/X3A2JKlJG/j
         sW5FmRGWvD6G/8xqVpi7I3jGYG9PjoF/yUiFJtGA3+/cpivJaB7b8eEpyP2zJEZTzdGK
         /o8RwKvs1qt27bGT8DyUBX5DY9/1K/XDT2IREFIh3ZdP0+BjdCHUofE/5+pG+CGESoAl
         cU2CVOkuS4nB2LbPUBowFSJdxFSJgO2914rT7RPvy2s+omMOUuMQmBMstpTjyF+/Cdn4
         OfrfrNuBzcuuvoiAP7de7xVKbHur8pDriiNAqMZLj1RDh5tgkwwmB/QFdEWoMGdCIw7M
         0tkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790621093; x=1791225893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9MUoqVvpT69Aq5ZarehzNgWsu7OePV3YFvLIai8Gmus=;
        b=YVM2gbMdA2Q47HpupznRjIt+6Fc4f/48cCj/As3vU2RaaIbdRDqLEg75M+w//aMJNi
         kStmG0+tXsAmiI770/XWOBRjgd5JDhdDfalto1XXpI3Gsa5RxnZEpqp51t1Vkc7YYbtK
         Oakttb6L8xZAmjifur3UK4jEM61pzNgrmykW5fKPmqmDTvSnthAoswR/kZ3kAVqmhkW9
         E8E/vKVbRo1TS0kSuurhkO4EWsUMPIpTMuDTY9Ig/VXUl8YWoivMhMiEAgPL4i+Aepi4
         YKiXoWEjDj2qEhh8yQ44yvJGfR29OaspgiSDk3dloURE/v+pvjphKo8Ohz82xv+fv6V7
         oa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621093; x=1791225893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9MUoqVvpT69Aq5ZarehzNgWsu7OePV3YFvLIai8Gmus=;
        b=Q7M1gZIMfpJvbdmfKWihDXVQBwFztsxuJ9islXYkrLKSRlbCVOtWgeiOgp+NAfzTza
         MLN21qLtlnbw1f/aFRziczH1+GQDfelJuLXRxKRIuyb0B0xTpKPcxhNmgH13tTJEBJfk
         QUdmKSqhXE+stEIcS91eNc6cbC6cu1c7UxZzRQZckazSTLr9ZhrufBW5pJIqmDzNKXeW
         a7mPUVgnvr7Oujq0GMODK4NGd8Rhrx180g1RR3HDTS/LXlAJdh9pkib7ujEew4I1117e
         Q8y+f2mrJLYaQkTBQ9q77iirxKyYtTnE08Y7iKHH67/NcQlDsXhw8wZtUWjQ08UTMsc9
         mOPw==
X-Forwarded-Encrypted: i=1; AKwUvBzcUul7/mSFC06akdm3NgbVayIsAuzXXKK5xQdo3Z6+h4jh6dcov0EEPU4RoEjp27lzFEnmO/icutdhPZKhRO0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK27ciE9H/exWRmRy+t57Dao2nBnTOugtGaRwIamKsCilaDGYUn
	jRRT4tr8onOiHmwbROD4Xl3qHAP0UGwqvUuJCNZGCFtlpM8l9tHPTyNMivBWjCfS+b4J4PgwGie
	zBntmZcWsJqe66Cdd/GyOEAaXiqxADZzKeAs2Ye4=
X-Gm-Gg: AYBFou1ANVGvqL7tGeieEDpsCbNT4q6dZY0TvO9N3BcmtSFA4EKBIm3NyIfLPLSQldj
	iMTQwRk3+fyaz2FLSO/6nsYD4YIXeuRh+/SmZHIYlFxZgD5t5zCrhj9DHK9x+geeytHbVAKU3eH
	2TNm5i+5TcFwqp7Hfjuq1BCoFWbtRvSbUJAFFLUGFJAiL7T3Wwc1A/Be95ZviKbnC91Hmmbk/hZ
	ObpGHWw3wbYAtNh614D8ZEmCmFYHnfn5NbQU8mwwjIud5mQQwBmQy0e0IwiZuOc3wHd/5dT80Yq
	agboMpN0XRSIKzcqzZ2UgyQB3ZJqFgJiDQT18shF+SNZ1/g/jv5RfhU3VeZ3iy1AaJZCA7cU4pW
	jtTp0dA==
X-Received: by 2002:a05:6102:549e:b0:7b3:3b4e:e4 with SMTP id
 ada2fe7eead31-7b33b4e251emr2377156137.2.1790621092753; Mon, 28 Sep 2026
 11:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925204423.80661-1-morbo@google.com> <605221ed-a1b5-4179-be8d-b206c79487d7@intel.com>
In-Reply-To: <605221ed-a1b5-4179-be8d-b206c79487d7@intel.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 28 Sep 2026 11:44:36 -0700
X-Gm-Features: AclHuK9vzOTIpe5NYpVAFSvvrNTDuflNtvpsUCuDxpjVBNqxintxAyJXqYTQDl8
Message-ID: <CAGG=3QWoa0sK1P2VEAW+76EkFsjzXEZ9ucJg4iiOv29i8Sgzxw@mail.gmail.com>
Subject: Re: [PATCH] gpu/buddy: add __counted_by_ptr attribute to roots
To: Matthew Auld <matthew.auld@intel.com>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:20=E2=80=AFAM Matthew Auld <matthew.auld@intel.co=
m> wrote:
>
> On 25/09/2026 21:44, Bill Wendling wrote:
> > In 'struct gpu_buddy', the 'roots' field points to an array of pointers
> > to 'struct gpu_buddy_block'. The number of allocated roots is tracked
> > by the 'n_roots' field.
> >
> > Annotate the 'roots' pointer with the '__counted_by_ptr' attribute
> > referencing 'n_roots' to enable compile-time and runtime bounds-checkin=
g
> > via KASAN and '__builtin_dynamic_object_size'.
> >
> > In 'gpu_buddy_init', 'mm->n_roots' is initialized first, and 'mm->roots=
' is
> > subsequently allocated with 'kmalloc_objs(struct gpu_buddy_block *,
> > mm->n_roots)'.
> >
> > Since the bounds associated with 'roots' ('n_roots') are fully set prio=
r
> > to any array allocation or access and remain invariant, this annotation
> > will not cause runtime panics or false-positive bounds checks.
> >
> > Cc: codemender-patching+linux@google.com
> > Assisted-by: LLM
> > Signed-off-by: Bill Wendling <morbo@google.com>
>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>
> Would it make sense to also do this for *_scoreboard and free_tree, if
> we add a new field n_orders?
>
Sure! There's already a 'max_order'. I assume that 'n_orders' would be
more dynamic?

-bw

> > ---
> >   include/linux/gpu_buddy.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> > index 2c36124bb696..d7249e500ab6 100644
> > --- a/include/linux/gpu_buddy.h
> > +++ b/include/linux/gpu_buddy.h
> > @@ -172,7 +172,7 @@ struct gpu_buddy {
> >        * a power of two, with each root being the largest power-of-two
> >        * that fits in the remaining space.
> >        */
> > -     struct gpu_buddy_block **roots;
> > +     struct gpu_buddy_block **roots __counted_by_ptr(n_roots);
> >       /*
> >        * Per-order free block scoreboard: free_scoreboard[order] holds =
the
> >        * number of blocks of that order currently in the free state.
>
