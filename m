Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274E3F0A85;
	Wed, 23 Sep 2026 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151136; cv=none; b=euU0EkYul6Vqj6AgEQRCqaXwJpeSyNhyOLeCcCGTPH+5Cfb5YgAn794uCP8o72ESyyd6PvDjteAZabNRbD/VAM4VI0WmISZd+M2M2UDrGHpyTwVrkCZYEhJshFRVaLhekgFSSxvAxCH+e3EpOVXvVzP06olBNHqvIXpEWfr3tTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151136; c=relaxed/simple;
	bh=dQi3vsQ80auOIHyLsIsNlKXRHUw5V0eOc0Lfm7xZrrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWInXRTIaTzAMg79UGzV84qlR8Ww8Ni7IhRwIR4p9vjvJpjOwxcErcC9CVYzjgOVFnzztltsoBntSDwtIvgA2k71zBuu31RUukAA97xaOCN3EitExhfRhDB3aBwCtsbQrAFK+4mllGw5k4JV/nbeheeYOYO9SwLeKQUx19FaFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V12ssdVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V12ssdVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B6A1F000FF;
	Wed, 23 Sep 2026 08:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790151134;
	bh=4RfQtrFJ309a+fLrqfO5VDKsk1rCknVTQEk2e9GBuqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V12ssdVBZdEg1YgzOEHBZ1L0Xf4ZbdwzSmtDM5u5ui74Ilhs7xqj9/dmT8mCt1Fov
	 33Gx7Wqkss8Vl/Zo5PMtWEcd5qK01uB16Hou0XgjVLfpwdFONElOxBW3P0vxQLHEqU
	 us3w4q85mbYaZkM1BZmDbLwNvBK/9Dnx7FSuu2oAZuNo3BgKfxIG/mQTC2VcWxrVI7
	 6KLxmACk1DP13sFF3MWN6bY1wtoEgg/Fj+hwOqc9xsBzUNywG3pS4LEVtoXLKLSKuC
	 suEE/hK/yuepyHS7V/YiFgUkrKEtE1lYUm+KWA/OxK8K2paI6mDe2oQykyeuLJ5m8G
	 x9tDwla2KMpWQ==
Date: Wed, 23 Sep 2026 01:12:14 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, codemender-patching+linux@google.com
Subject: Re: [PATCH] bus: fsl-mc: Annotate fsl_mc_io.portal_virt_addr with
 __counted_by_ptr
Message-ID: <202609230106.7960C12@keescook>
References: <20260922223538.2287676-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922223538.2287676-1-morbo@google.com>

On Tue, Sep 22, 2026 at 10:35:38PM +0000, Bill Wendling wrote:
> The GCC and Clang compilers provide the __counted_by_ptr attribute,
> which is used by KASAN and compiler bounds-checking to detect
> out-of-bounds accesses to pointer fields.
> 
> In "struct fsl_mc_io", the "portal_virt_addr" pointer points to the MC
> command portal virtual address. The size of this allocated portal in
> bytes is tracked by the "portal_size" field within the same structure.
> 
> Annotate the "portal_virt_addr" pointer field with
> "__counted_by_ptr(portal_size)" to enable compiler bounds-checking and
> harden against potential out-of-bounds accesses.

Another one where I hope things agree. :)

        mc_portal_size = resource_size(dpmcp_dev->regions);

        error = fsl_create_mc_io(&mc_bus_dev->dev,
                                 mc_portal_phys_addr,
                                 mc_portal_size, dpmcp_dev,
                                 mc_io_flags, &mc_io);
...

        mc_io->portal_size = mc_portal_size;
	...
        mc_portal_virt_addr = devm_ioremap(dev,
                                                   mc_portal_phys_addr,
                                                   mc_portal_size);
	...
        mc_io->portal_virt_addr = mc_portal_virt_addr;

But it actually reminds me that I still want a warning for having
compile-time warning about pointers being stripped from their counter:

                status = mc_read_response(mc_io->portal_virt_addr, cmd);
...
static inline enum mc_cmd_status mc_read_response(struct fsl_mc_command __iomem
                                                  *portal,
                                                  struct fsl_mc_command *resp)
{
        int i;
        enum mc_cmd_status status;

        /* Copy command response header from MC portal: */
        resp->header = cpu_to_le64(readq_relaxed(&portal->header));

Not only is mc_io->portal_virt_addr separated from mc_io->portal_size
via getting passed to mc_read_response(), but it then immediately gets
cast to struct fsl_mc_command.

We should get the __singleton attribute so we can mark function arg
pointers as "not an array", and then these kinds of casts could generate
a run-time check at function call time to check
sizeof(struct fsl_mc_command) against mc_io->portal_size when
__singleton was there, or kick up a warning that the counter got
stripped.

Because as-is, this patch is a no-op: nothing dereferences
mc_io->portal_virt_addr with the counter in context.


-Kees

-- 
Kees Cook
