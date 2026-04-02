Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987E37C93D
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156963; cv=pass; b=lTexdu0rMQSxIcbs0JECcztWSPPNRBWgzl6cWzsyJgvY57U/ylRWLm1tLwB1EeA4hyXFIkTmtGIs1JXCZBU/+2tno2IVtiR3G/2ImwK/7Jt1fwSt6i1Vx5bBv2hMuONBwr7JQP+VpG49f1NDbWF3aVBdLrOdtGxAm5+1n267iAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156963; c=relaxed/simple;
	bh=AkTXuskHgqFSHuPaesiQpEtKQBcqndFo0G825t42ZQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjJPVY5YmZFofJltLuWvryImtmtVd6bU60m+hpE6wPBxVKIyuKCFkJU1b0JgufWPdXiINnfOG9u7NfbfjpfKSSDem4oNUrUoE2ivjyp1y6Sn0Dl+1i7onvtqsxOqAH/H01PhqNHbXLNm0rPUYxgubz3ZXd5qZdLIdHasvnCouI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VGMOaEkS; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGMOaEkS"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12a74039dc6so1124444c88.0
        for <linux-hardening@vger.kernel.org>; Thu, 02 Apr 2026 12:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775156961; cv=none;
        d=google.com; s=arc-20240605;
        b=I3NuNofBIxUo/pOPUJ2zGCuEFeQpuf5QLQyniZLtzoG7Efaa342Kf78Tb0URA82v0A
         U1LLW6f2ovtApqCedEWWGAH8tMdPF+2+5YzNhbd+WpJcsvjLIui2RcY2gO0fZRt3IjSD
         /SJ5YsoZtGeXCNMgx7PV6BW0ipqRRiJ5RIMQX9toUdq4lyBI2q6DdR74C0WA6MrzCo/Y
         VvAxvTmJ6h2t8WCc+GsGpaylw6qE/x6E0a7osN4ofHJvcwjBRAcTnW9Lqhe3d3Jjrl8r
         waoYUoCAZrxWUmLEsG3ARCb7tyMERJ8TyAb/wE8v2g8tOgx511htch8hFAtTcrGCnqFB
         r9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=26jnDOH9sfu0NBZTRbOR7+Wdjzvvt/AkBoHu3e7kTgM=;
        fh=uhZPxFhvlFwxMGUCGUFsN7sh1/RrAxJUTkYZy7DokKA=;
        b=frM4l4X1iLRzTJvuDugaW4AKSToGN5Jf3JinKd1wZaG7dtiBpdxeaRPrC/kbt34v8+
         hWouWOOIpg5x6iUdxZLdTUXOZrLsXhwJRK89q/m3R7cwy41XvJ6gCb8zor57dEG9pAX6
         IAQcGvn+De6cWEMXiB6ox1BCHJvY14ZWqM+vpudbdwcwAd7iYfW5PkyGhbHy+LLfaVLd
         AsgioxD3m9jrFNk8y74fJ2mBMixBZsjr+r4/9fbvjEfnbmE3pr3dARe32XO2s5pGDzK0
         qvv696S1UOcBSbO0RsPR0Mpn9jEMG4KXAshltVGgFn1YH6qGtZE4y/9/IoJJXvAO4AlN
         c5tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775156961; x=1775761761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26jnDOH9sfu0NBZTRbOR7+Wdjzvvt/AkBoHu3e7kTgM=;
        b=VGMOaEkSOxjy1YLxZiA4Fm3sc8vHVgOV6Tk9/NjLqNcZfTVB6s1lbaadXm7knQhHJV
         eHTDdP2wMHlKHlylZcsHC2Krr/NHovpEuVmHBiyJE9+kDXS7mu6ArhnljKG52SbJbL69
         mBxdjgBKmNV5n1Gtfy3hLD/m9eUXc5MvR/HJEVclfpEZgpc+Zi94GXuOJZjRNZkEjcSk
         wAc++e8gEFB2Sv3reOU3QU44q/CRauE4wCBtOxp+xnPyPacCvOpnKq43H40AyarCP48W
         2IEZRiVBzWcPvoKpZm5m0df0xPTfC2iANN9tq6R6BhI8gcJ07Vmzq8KOLhMeyM7oN3PW
         jJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775156961; x=1775761761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26jnDOH9sfu0NBZTRbOR7+Wdjzvvt/AkBoHu3e7kTgM=;
        b=gqyvpPodz/Ym0fY/fKGMOFTm6LAacaaizgIYdM/49RxyORUnKvmv+d3kzMAU0FnXyv
         8b76Ynr9dJP4ja03wxEIzqiTp/K0izWoYSPj8/4503zp2EqSxYjAOfKfuJ7T1U2kGOZY
         C7zd/Pa51GtAmqk1zT8FmnqdJlXej+cTCLqLpwmOtEqcWBHRaGe450fuTyZw08Z/WQ9X
         Q7rK3mn24SxU/ZhjZQv1tlsCEvdDCVpFsyhZw3fZRUNYIZlTXWWKtzqYA3h2xS1f5ZFh
         ljzGx4J089tnoY2PEIaerpip/myxKuzXPd2Xn9Yf8Jt7R7zjgoqBZR1E7K1vFDvKCEnu
         P67w==
X-Forwarded-Encrypted: i=1; AJvYcCUN7d/mCfrP+EHgmIUbqE1m/AwCkLnyo9fr2OkxK+7FgciyY/57yPvLs0MasOZsoDmHfSfvjoHrmTv+ooYljEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZBKMGAV2NqNyQXS3GeWO2qBqcCjSqNVgAykrZ8pOBfgUL8WU
	kATIhII+W9Wzjj9ISkI5+RlmHpjXPHb6wAaHG6sr7NdFqJredmkY6gEVM5lRDFbaJQ9xa0waEK9
	cfWM7tUWZonGcU4BzlU7ZPpDqWDPrYsIw1BlhXMbU
X-Gm-Gg: ATEYQzwT8qu2USi10FkV8NqJvNbWI5NTAIRvsWgw1r2J5e5pAI3rlCbnkLDI5/AfFKt
	JtXoVO1MRWPoqZVzYRzJ0dEtUtBMavd+NqRq+MiCAzVYUWhevsvaygCj8ThBYENP7DeDKff0amu
	VPY7BvGAWjkxeStv54csMtroH82s+YwswHoUF/lwkKVdQ/K25hNjXFPL+OFLVpJUV7Oi/JfJC64
	0vFwLhxHQCU6oUKFQjh0F8gT13XZhwMDhDRUm9zAhn/Ux/kBioAkhKR6VS4CWivIQC6uSwWLc0U
	X8ZffZdTMem5bB+rt17TSTjHH623+2fx1JauLc8/utT1XBE62A==
X-Received: by 2002:a05:7022:ec17:b0:12b:ebb8:e518 with SMTP id
 a92af1059eb24-12bfb779d53mr79037c88.35.1775156960783; Thu, 02 Apr 2026
 12:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331111240.153913-1-elver@google.com> <202604020400.jEq32K95-lkp@intel.com>
 <CANpmjNOsM1e8jMvRKtEizMmZgPCCZ9YqpuZKad61Zg7PAGW7RA@mail.gmail.com> <ac6h2jF-KJ5pm1WM@stanley.mountain>
In-Reply-To: <ac6h2jF-KJ5pm1WM@stanley.mountain>
From: Marco Elver <elver@google.com>
Date: Thu, 2 Apr 2026 21:08:44 +0200
X-Gm-Features: AQROBzAm7ykm8zO9ipWjQHBso2-gdwz4n-a0cr85SYjLzctukNDeZ0kKGTltKIc
Message-ID: <CANpmjNPME07RK+jKnw233BYHX7wVMqCzFYpB2cSN4+DMgTSpuQ@mail.gmail.com>
Subject: Re: [PATCH v1] slab: support for compiler-assisted type-based slab
 cache partitioning
To: Dan Carpenter <error27@gmail.com>
Cc: oe-kbuild@lists.linux.dev, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>, 
	Hao Li <hao.li@linux.dev>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 19:05, Dan Carpenter <error27@gmail.com> wrote:
>
> On Thu, Apr 02, 2026 at 03:48:20PM +0200, Marco Elver wrote:
> > On Thu, 2 Apr 2026 at 15:33, Dan Carpenter <error27@gmail.com> wrote:
> > >
> > > Hi Marco,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Elver/slab-support-for-compiler-assisted-type-based-slab-cache-partitioning/20260401-035608
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > > patch link:    https://lore.kernel.org/r/20260331111240.153913-1-elver%40google.com
> > > patch subject: [PATCH v1] slab: support for compiler-assisted type-based slab cache partitioning
> > > config: um-randconfig-r072-20260401
> > > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > > smatch: v0.5.0-9004-gb810ac53
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > | Closes: https://lore.kernel.org/r/202604020400.jEq32K95-lkp@intel.com/
> > >
> > > New smatch warnings:
> > > drivers/misc/lkdtm/heap.c:118 lkdtm_READ_AFTER_FREE() warn: potential pointer math issue ('base' is a 32 bit pointer)
> > > drivers/misc/lkdtm/heap.c:169 lkdtm_KFENCE_READ_AFTER_FREE() warn: potential pointer math issue ('base' is a 32 bit pointer)
> >
> > How is this related to the patch I sent? Did the <linux/slab.h> change
> > force rechecking of all these files and it found latent issues?
> >
>
> Oh, crud.  It turns out that for this check Smatch allows
> integer_array[sizeof()]so long as we know that the index is within
> bounds.  What happened is that your patch renamed the kmalloc()
> function so Smatch stopped knowing the size of the buffer.

Oh, I see. Smatch doesn't respect the __alloc_size attribute then?

> For these zero day bot warnings, the emails are automatically generated
> so I don't have any context outside what's in the email.  I saw that
> Kees wrote the code, but I figured maybe you forwarded it or something.
> Sorry about that.

No worries and thanks!
