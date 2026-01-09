Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8EE2DB7BF;
	Fri,  9 Jan 2026 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994497; cv=none; b=R57cbL91ihMoVc9l09fvK73C0Y3Cc60KbSuZxfGzFJmgyQhs2d0lLJLwX+fs3bzETeE20ZPqVZlnOZZufJC94tldLIIMCkrGKxUp8dMn2JTpwEa4V2NbeBOvV1yjXXcWwDFDGuHBUbQVDjqTThir3+w8vdfKtlDxd2M2ftM7CcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994497; c=relaxed/simple;
	bh=s0OxAMLZxOlIwmSNnHbqVjMBf0UkhI/liDUCBa2weCU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oy0wLFEWVpAtsBAJoSTF1Feh4Z7Q5ITNKdrKdv0vul07KSskyXt8kAY7+suymAojMddwDib2FPrFKUV3ngURPr/NlbOAdViPrkL90uf6jjb+tA6Mu7XznXVzw/iDGhbGX0OuTQmp3ZmPzYwDy48JW3LJI5aViULwzn4sZmnaYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id A28B41003C0D51; Fri,  9 Jan 2026 22:34:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id A06E911009D12A;
	Fri,  9 Jan 2026 22:34:52 +0100 (CET)
Date: Fri, 9 Jan 2026 22:34:52 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: Ard Biesheuvel <ardb@kernel.org>
cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
    linux-hardening@vger.kernel.org
Subject: Re: [RFC/RFT PATCH 08/19] x86: Use PIE codegen for the relocatable
 64-bit kernel
In-Reply-To: <20260108092526.28586-29-ardb@kernel.org>
Message-ID: <p64p8514-np9q-r4qp-6254-011r62nrr594@vanv.qr>
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-29-ardb@kernel.org>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Thursday 2026-01-08 10:25, Ard Biesheuvel wrote:
>
>As an intermediate step towards enabling PIE linking for the x86_64
>KASLR kernel, enable PIE codegen for all C and Rust objects that are
>linked into the kernel proper. Add a Kconfig option RELOCATABLE_PIE for
>this, depending on RELR support in the linker, as the relocation tables
>will blow up the kernel image otherwise.


> KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch -fno-jump-tables)
>...
>+
>+        pie-ccflags-$(CONFIG_CC_IS_GCC) += $(call cc-option.-mdirect-extern-access)

I think that dot there next to -mdirect-extern-accesss should have been 
a comma.
