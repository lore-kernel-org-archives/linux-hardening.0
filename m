Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BC244667
	for <linux-hardening@vger.kernel.org>; Sat, 17 Jan 2026 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768677532; cv=pass; b=QGo6zf2uwLSOWns4GlpIIWmi1vPH4+z4D5hRwIMhsXYF7qppTEg4HDO+UNs4P5vYfqv2s/+eqsz/plxIoI3fGvANqee9BJsfOt5fAHd9DG6zUnWcDrO6GfedZnouVIg7ADehFFrsX5Y/QrJPuXQAz0bavxoQXDEPtXi9auPP09Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768677532; c=relaxed/simple;
	bh=4nRx1316BjFdC0wA6dN1j2Nv3iZ/DZZJzDWc/8OJWOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9QLUM9ywIHQ0UXz5cbtLuqz3tq0ZH4OSYBQfGxkRnbavOfAJGKh8tEwXotU803mPzGvFujnxjoP1/q03VKHmNky8bneWLlIQAc78GYEyl1Nf414bOqY4sndEoma/ptffPed7su2QD/Skym+TRHuHQP7OW7tcMPZiM4GSPYaJuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gC2DjrOH; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC2DjrOH"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ae5283dae8so201220eec.2
        for <linux-hardening@vger.kernel.org>; Sat, 17 Jan 2026 11:18:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768677530; cv=none;
        d=google.com; s=arc-20240605;
        b=iQgZXPlOGqf94n5Uik2JuW0leY11qVZR0M2ILDhbVugmBcXCz8vpEnyYKySnSUHR2C
         XChcBR0Ly88y20BjREh4qrp3xqpLO4ak4Ix4d5L74OxyVVnc8yywceN/O8VhDTAjfx6W
         fWo3eFJgRHlXPPvRsCsky/bErilS7iuAeXIIYvRH2wJNC7WC5abJcWAx0+huyMqvy7yC
         xKhqVZBaA5y4WbAB3vdTFHAuChoUIPRR66am6jOmM34uvDAEW3nPFrw0VYlBZgneY2Ex
         JrFuvmElTnn8uASPndnUE1Z+/yaJwI82x5BVMGCdKDXtdoNKU/TQK9wdTkQ8YkresDQo
         NLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4nRx1316BjFdC0wA6dN1j2Nv3iZ/DZZJzDWc/8OJWOc=;
        fh=t4t5GpgDsl4K41nAwHq0KE6WNu1ohzLQa2QGKiBxq68=;
        b=KHv/nLHxDweGpbwJEmmBL6mXj6BqPXCSY/juO5/MF10joXUlz3jJYS49ak8pODUmys
         sllOQEnEAp7rKD8Y8PQF2InHDOYNkPXp9d4zVXpeAD/S9AvdIipWG0GJ92+6G3D8aToG
         9gl7AlwNGxxwbBUQ794sEzfyUd0knhPMtAZgCpz90w69NfB7ZxymmQnjzAkq3Y0FWozg
         oFn0SwHlgsoC6tLmuDjGyMe5roa2Jo64LwObxRGxv1o5XVTW1dd8b0d5msvAgyuO6n17
         8kfnHjofsEVKlgSLskAit8IUF2REM0RE8IjGNSuCknMqmnHQpKzoeJ4Sb4xYxs/3EYPs
         JD7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768677530; x=1769282330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nRx1316BjFdC0wA6dN1j2Nv3iZ/DZZJzDWc/8OJWOc=;
        b=gC2DjrOHTJSWKlfJgmRBejqnhc5z7Q7NE+QDNiuqWoNdjGFnWW+FDvdZGH3IvP/bDU
         ryA/Q0oCBANgnMPDf8TVmNYtsWw3TB0KquSXQcXQgt7APpMuuj/ZRpPfuvIvC+jxrIgI
         ROZza7dtQvDhPyFWRH8MwwUq8vNu4xtuFdJtOVcMiVI0vYgvyFBqvl3QYAEaCBMdp8s8
         ThQCgdlulv1FqgAk2Ce9xlefKThQPzCJMG4PsBqCHbvlFJTsrHw072fH+m/K1lLVOB51
         Zjt7ZCCQww1dAuQDYFSl4HPmkUBpzhYbbbhMEpI32TFeMtDWyvQDSpNQRyV3fORzK9gL
         2xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768677530; x=1769282330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4nRx1316BjFdC0wA6dN1j2Nv3iZ/DZZJzDWc/8OJWOc=;
        b=lvlzYe+DPHG2wErMu/j8INK6Z2ogGK6MC11XFJptFNDqGPrlU3r+9wJcKKZIOjT6xl
         pIuXWtOHeZFEm3oGY65fFn7qYvRtLBc4Avrdt1QlWS26B0SbKYug2iU9Qp9wbcJkSlEy
         CRc3YmKokxlILtH4n5axwtXCq46tK1YRdzeobwfWZMX1rRAKkuaiD5AffCLTCNSBPBIc
         E9LVQGko1DolZHrB4FuHp/h9oqAtkxDDzta3LpZIYSkoSUb+zonYfk0GSBfIwCDJ5O0D
         aDdZCMDrl0X6cvxm/Ek6Hsw/F5VSjkfH8DpHWVfZB9pWJ7/OCh+e0iufciINzzjN5qC5
         ZeIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgaXm1WVjGPRt8vxebNb8mMl4CtRlZ2Sw6FPnqNhwP88dzQbOLrU88vd6VU/dw8J8zfGBuKFppfFTQY3drXcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyws8glqZbAgpWfdLlMoYmb/jrbIPDhqkRhtaN9K2n9NXEcGa8p
	RSyeXVQ8gws+6ZKqhVHZ4HgqAKvJ6KjqUZ543CkdT8yVAwfLw1EcgNQBrIz0i0VsSa+XkI3K5pu
	rG4N4c91vr9hGQDGmExGH3iBFk+EwUIE=
X-Gm-Gg: AY/fxX7n1/eQvBWtJd5r2B77xYAkhCPJ6C4u4kgfJtHeh8K30Q1WVeA0m9qvpkcBN4x
	ZuyOEgv/d7tQpZ7A4VEy4+AEgfr955nNhkmrMiOpF8H4lQL64m1vr8+MlRSS4ce3jQo30CfIx74
	u4RvxGwmiXfM5RW9rvovMhdxA0tgN9RnvFj43Xh/YRpUdv8Wa7pxLYPCR2gLf9mBnzrW4gt+3qM
	ZfK33bfT1Glg4zlXxxYIVdeIuxXsJbmzcnwUt0vHhsQZo3AMS9UGku/BxNGToYhK9B7Ag2p86xW
	LGSLtmZXDdWgiaC1EjqvqBSeR/26eDdF/QHnDMhwzw7xNgfJlSoXlsnQyTKfo4Y7SCN/WrvLrYh
	lBWPJwMJ6w3yg4CW32qcDGk8=
X-Received: by 2002:a05:7300:2211:b0:2b0:4e90:7755 with SMTP id
 5a478bee46e88-2b6b41219a4mr2905035eec.8.1768677530129; Sat, 17 Jan 2026
 11:18:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121193957.1655580-2-morbo@google.com> <20251121195504.1661783-1-morbo@google.com>
 <CANiq72=kqJApbOJ0hmC_mAYe6DO8YqXSFaLJOsbPhkXfxmvJHQ@mail.gmail.com> <20260116083516.GI830755@noisy.programming.kicks-ass.net>
In-Reply-To: <20260116083516.GI830755@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 17 Jan 2026 20:18:37 +0100
X-Gm-Features: AZwV_QiRXF7YOSvgOkGp7Qk7spiRaCAL4aYaIw3HFRjXJ-5zQKZ8PQg_RAG0TiA
Message-ID: <CANiq72mCDAKF+PEkUDHBSNcnfxiAU1oF5RA7zysTbiU+x7m3OQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Compiler Attributes: Add __counted_by_ptr macro
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Qing Zhao <qing.zhao@oracle.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Jan Hendrik Farr <kernel@jfarr.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 9:35=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Kees promised to drop this attribute once GCC-16 releases by basically
> doing 's/__counted_by_ptr/__counted_by/' and unifying things again.
>
> This split out state will only exist for a very short while until GCC
> has a release with this feature on.

Ah, I see, thanks!

(even if it happens later, that sounds fine)

Cheers,
Miguel
