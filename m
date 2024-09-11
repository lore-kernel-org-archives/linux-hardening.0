Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA978C9D;
	Wed, 11 Sep 2024 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093077; cv=none; b=iy6SfOAKWG2WqL+KpYM0Sk/kBXIscMNOr8ZZtJ63NTpxh0RYRRw+Tt7pCjclN3h9z5tpHlng9HTZ/NioRcSnFf1rCMPUpTUcte251ZP62vgPZn+1z7gDHkXY7wpM20U1qsCEk2dzsrkp0+MzQpG6iqyv09jT/c9Q47Rcc+rK8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093077; c=relaxed/simple;
	bh=8hESPHedU+ENYGrgiTg2aQkKK1dO07lnpjlYWMsSgFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0Y5ncd83PtZ5g1Cw4RTN+KdzkOzFUeY09NO1eBXcxATDMhxqzxnNbBsiODJyW3OjCIeX0A/T0ZbiA0EF6U1Gi0003VA86F9AuIS5Hmg8UcNxsgpXf7/AThoJLhp6St7oDrya9R6CB8UMNKhuO5yWrJQR87lUFLN7h0Je8f66V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG/xfp1A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG/xfp1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF085C4CEC6;
	Wed, 11 Sep 2024 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726093077;
	bh=8hESPHedU+ENYGrgiTg2aQkKK1dO07lnpjlYWMsSgFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aG/xfp1AsFxxDmMA21Vujsx3gz8BU65cYKDoFnLk8hluj+5HCFGjrxMuCw+Z6D5Yb
	 Ar9ABnQnEjtJeJk9eC4nNpHOrjlLuQPoxnp/I+gyMuU9QSUy/3/9s5TqbW6gmkHRqq
	 DgoM07a/lkJiEOR+K67MpXSaX10dyo+BbWUAdDX8dKdqCk5uMWDrKhC5tDkovC5Hwz
	 FmHAMspWVWb/nLMkj/cxJmxC6fPJZ/8QJVBbxOomWn/hrrVytKWHbo1BQh5rjMcv9L
	 TbjQeCBm2eBjdZcj45gIHmmvyqw6IOG6hA3Ev5C/nc1gzmXBuXmYRnIjQt2xL0tYX0
	 GEyZyen2H3vHA==
Date: Wed, 11 Sep 2024 15:17:56 -0700
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	jvoisin <julien.voisin@dustri.org>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/5] codetag: Run module_load hooks for builtin codetags
Message-ID: <202409111517.2461E9DC4@keescook>
References: <20240809072532.work.266-kees@kernel.org>
 <20240809073309.2134488-2-kees@kernel.org>
 <CAJuCfpFY9=NOftvaKqkuohZH9L1QTHshORXeqLomrHBPPTd9kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFY9=NOftvaKqkuohZH9L1QTHshORXeqLomrHBPPTd9kw@mail.gmail.com>

On Thu, Aug 29, 2024 at 08:02:13AM -0700, Suren Baghdasaryan wrote:
> On Fri, Aug 9, 2024 at 12:33 AM Kees Cook <kees@kernel.org> wrote:
> >
> > The module_load callback should still run for builtin codetags that
> > define it, even in a non-modular kernel. (i.e. for the cmod->mod == NULL
> > case).
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Hi Kees,
> I finally got some time and started reviewing your patches.
> Coincidentally I recently posted a fix for this issue at
> https://lore.kernel.org/all/20240828231536.1770519-1-surenb@google.com/
> Your fix is missing a small part when codetag_module_init() is using
> mod->name while struct module is undefined (CONFIG_MODULES=n) and you
> should see this build error:
> 
> In file included from ./include/linux/kernel.h:31,
>                  from ./include/linux/cpumask.h:11,
>                  from ./include/linux/smp.h:13,
>                  from ./include/linux/lockdep.h:14,
>                  from ./include/linux/radix-tree.h:14,
>                  from ./include/linux/idr.h:15,
>                  from lib/codetag.c:3:
> lib/codetag.c: In function ‘codetag_module_init’:
>   CC      drivers/acpi/acpica/extrace.o
> lib/codetag.c:167:34: error: invalid use of undefined type ‘struct module’
>   167 |                         mod ? mod->name : "(built-in)");
>       |                                  ^~

Ah-ha! Excellent. Thanks; I will double-check that your version of this
doesn't have any surprises for how I was using it here. I expect it'll
be fine.

-Kees

-- 
Kees Cook
