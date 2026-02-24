Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2C3A9D96
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955687; cv=pass; b=td4raYHNKTJQ7DagBi5VXaB+HRkId9IeNuH4OFvD0yzATlK8hiUO0hTUpYBQBm7RKTgFkoIPiSsD3ck81Esv6dypAO/oS7ubG4ti6i0bmmT/+hkAxqL6jxfe7+FUEdc0AqscIN66lfQIJzUPet9WZxCD5t6HdcEy4qnjBESHMwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955687; c=relaxed/simple;
	bh=cL8oOg+AE1EaMyUuotbxmwWljFkg5OQ4erwQs+K3UoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2GEEBllEvNzs3ySs/rp3ckRhr1DANi0wDbc1y8vLid0UM90T+VzteQVsucpnya8Wf0uuiFwg4PEMlf8wvFGkwaPFv5VYvVsabx6w+y1nR/+VezYIWbite5mQayL1NkX+RETcWTwCRdFcnM6CdWqC4CUoH2J6xOlIFZXeUy7E/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kMXc5uir; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kMXc5uir"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506a355aedfso17011cf.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 09:54:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771955685; cv=none;
        d=google.com; s=arc-20240605;
        b=I8QgfJEjVbUbITQFtDmpxMUsfvTJOQxJHgqbK4ZN1qw400FnAKYee+zJYELn3eZ6FS
         olCgcjF4PkdMwTX2dzQUqKvP3zrn9C+J8dI+6K7+9uaNnRfz56dyJOZvNNylo7b15cMB
         aoilXLGEcgXIUzQXT+VqVrQwkKkZjzMJlBE/QkwXV+LyzyFF+acoEJN7ONHiIFredWul
         s7snC1g36+9nOjmNvHMoR6sXJgvdzRB9da8mTXpdRmc0P94hsSe3wbgAoGeu7g1nkObl
         I3pVIW0BJPv41l59v9MvGkSFM7yBgTzQdGyDAdK+UrKQdyec4+Q3NW7OarP/VZoUvXBo
         5hWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Zw+oA7r9ffWSYOcX5scdzZ6M/dvv9GwuwdHSRZozCso=;
        fh=bgY2lIH6E8K5d72gAX0hrmb8nFzPfNRQcdcxzwtv/c0=;
        b=cx1ilGeFPAqNSrJT7c8PbaSx9TeWmT56p9X0J2hJVVTUUXQmx95fm6XW5G5Cw0GBoN
         0YhaZTheswuGkPGeA+LKBfIcOzFtvsU8lSE8NjRLw3bUVam+kvn95QhJDzalFi/zOaDP
         J3khpsvLHK8wBQ2RLf3ypbjHJQE/oGINx+0fgeD4NLe9/iP3fLHq2AXqpyLv6kEZoF1Z
         2SFvWA70kpxeG995QqlrKRA7kZDItu4ANTXRHJ3vV0d6Doj8x4VHeiUdfFLIaZ5b/Wbl
         YYkWSEVjBEVvn+LYJxEkzb/4+qH1Vn9wa8WkZ0lYlTsB6jrukGT1M71N4Ajc/ikSrLVI
         TalA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771955685; x=1772560485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zw+oA7r9ffWSYOcX5scdzZ6M/dvv9GwuwdHSRZozCso=;
        b=kMXc5uirgkDMP/i6dpGD8p1kINaMyRJnvnTrLmFzi5SqxVRPTYwwDRW1yAapBvmbo9
         zj+XGsHbRTsjiWDR/VkT95KRApMtyJS07bT0mdFS2tar7dJyNM1mCUxxn6AMTdmZMRz9
         y5uneEG+EvmmtGJDC93H/gu+RTyqk2suaOQfNqASv3osaPd5cj6Runb1YrlOdtuJZrQJ
         1bHYGH7Y/d3RUCVSAVoWKY5lAP6JMxASxMJpRbMfpyP5/OWzzEoJWd2vYl/FtyaNyMRy
         HiKH82Uk3Bht25qA7n8mmkHDNz75lJvDFR8kjwi9WfZ8890YLkCa070+xthLsqqNdvXO
         VzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771955685; x=1772560485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zw+oA7r9ffWSYOcX5scdzZ6M/dvv9GwuwdHSRZozCso=;
        b=H1wag6tG13raG8lgVqXAkBXDImMAIPQ3xQmS4AIR1UXaE0GZA3bX/s/HsngRMdW3nL
         fwItt+RDT9ps3rck526qbtTnZFSam4Dh1VK21T9se/doLHaYYX1VCtgNV7rYk0jrQ4bV
         eIodY54XWpWBDVVX+uJhch9Ca5LS/Tw5wPtIEZAyhXK4ab7Jf+wuek9FNRjnovcwKLIb
         xP+N+WvJAGCLBMTJwfwQqziJdzOxa5Hm/79gHiebOml/iokKwmR83oWJuEL31ui+BTE8
         s2eARuxGo/bdZ5bmOYXkGaXDNbe+JqSXUpGjV1M8XE1HFsZzqzastcvCk0J3TLlcqa+S
         95vA==
X-Forwarded-Encrypted: i=1; AJvYcCXWlt8d20GyCN1t4UX8I0a53oE3KlTowhcmodCNqHz3DZMPmrqeOAZ930+UPrM0lqLRhMtngIcZK3W05b3dTjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzApeIWmYS4kYJBQRlBRodGuLe2NmmBeiks/p1XxJOQ/yj14hmV
	jtkS7egalsP95PVWxc10rcogjTypkz625cenfc1gqil2qosQkTalzOQ8p1qBxt0O/utyipGjcqX
	uqc9trZh/Xeboe7OoHOrkMU5hyXuzWryULNluzIfH
X-Gm-Gg: AZuq6aIsbG/m8XqD19OK1Ac9B1sk5ViZkXUQcVkRtiZoe3vQWaG1U/r1GFAucFxiKdq
	37Tx4eL5581nu50NSkoAfctPqfkhAZjwJoriQZSyzr8+H5J3Exibl7HuSkBokR6Tja3EPQVl9fR
	djFbSdeaeR/BeMVI2cbND96dMYbJHMFlrAY26GVbiINAEzY3OQXhH9IBj1xE2DasnBP7bYRJbWw
	XajiOi7ADJ3DGUx7mUhvRDF4b/hyPfV75jKMgsAAVgTt8BZ4YiJpZnsc7mjfHiUPM/vKZq/94Kh
	8sSro634vP3eNCbOwlA=
X-Received: by 2002:a05:622a:190e:b0:505:e719:3b49 with SMTP id
 d75a77b69052e-5072df07d09mr13088971cf.11.1771955684260; Tue, 24 Feb 2026
 09:54:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224170427.2296592-1-tabba@google.com> <aZ3eKyVXPd-Fvcst@smile.fi.intel.com>
In-Reply-To: <aZ3eKyVXPd-Fvcst@smile.fi.intel.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 24 Feb 2026 17:54:07 +0000
X-Gm-Features: AaiRm50XpL6u8toHp8UDHK36zm2Y9xjMR4yXgOYcaTvIPGdMrXE4y2B3j8wvL-g
Message-ID: <CA+EHjTxgX8RpVxdf1rrri8m_=oG-0_KpYzhEKaZXXOr2UXWegQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Fix UBSAN misaligned access in sized_strscpy
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Tue, 24 Feb 2026 at 17:21, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Feb 24, 2026 at 05:04:27PM +0000, Fuad Tabba wrote:
> > sized_strscpy() performs word-at-a-time writes to the destination
> > buffer. If the destination buffer is not aligned to unsigned long,
> > direct assignment causes UBSAN misaligned-access errors.
> >
> > Use put_unaligned() to safely write the words to the destination.
>
> Have you measured the performance impact?

Not directly. I verified the disassembly for both x86_64 and aarch64.
On x86_64, both the raw pointer cast and put_unaligned() compile down
to mov %rdi,(%rsi). On aarch64, both compile to str x0, [x1].

> Have you read the comment near to
>
>         if (IS_ENABLED(CONFIG_KMSAN))

Not until now to be honest. However, are you asking whether
put_unaligned() breaks KMSAN? I don't think it does, max is set to 0
when KMSAN is enabled, this entire while loop is bypassed.

Thanks,
/fuad

> ?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
