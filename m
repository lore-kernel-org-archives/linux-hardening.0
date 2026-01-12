Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B41B7F4;
	Mon, 12 Jan 2026 04:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768190541; cv=none; b=VFAJJrA9Il1DtO5OnAmvLwllVxkWKN544MMnUeBykmwfC8Kv01gMYNPktb4hJsz8gvkVLqNr9feSNpht9BZ158uSa1nS1Z4RyVNpDQdRXCNeudr2CILa6UuGA8bpaqqyGt6VUp6RhWvlPlf2Bq+Pe7hsCEnzD5sgtDJaaJDPBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768190541; c=relaxed/simple;
	bh=XIUG7aYBz2GSjH8VyarZcuEWT6uKwvcqE9seyrdgNqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZS8pUvmTSPC54QPszbaryqqXR9xHYULgAx/h8Rclpw0CMq/Hvzny0V4z4mAnMeM3SjyK5FPVNeQBL/vIbUhKJMzmtJrsh+SvfQmW0HwPaeLZS4/FwrB58ZUovcj1IPdW9dLiOpCa0bPfVU9k+QfIXgdSuoMp3SLB4u0ajWaJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=f3Ek8aRK; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f3Ek8aRK"
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60C412iW1765885
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 11 Jan 2026 20:01:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60C412iW1765885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768190467;
	bh=SCtgY5YmYEcmGGLDPGoqGQP5fT1Y6ZKUOJ4BIQp+azI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f3Ek8aRKzUMVpEn3GXfsPUo3dGYOQ+k7OZt3KjAdPK4TRQJErVik/y0bVSG3SCpCZ
	 zWGlvzOdSV1Bv5OmIYZOo9ZQxYX0xrlOKpsBMP23qQ+onD+qv+Fdm0S4/lQt8s7HuB
	 rPLrqHbtJ9fcA2XgmucGXcD9eCkaQPVzsn2XASBNNMzqmJPOEmw+fwpigsNEBcETfu
	 M9jawAVzveNzZ1JQdzrEKPYO35CDrgrFJArlnFxCsIVR9sKJPwXs4709XPivWaXmVU
	 CgiO6RSNdoqxz9h4jn1dacrUHPR+UXD+d9AElLTNZQDEBLAh0CXj75kOGFfwlfuF67
	 LYFh7Mtk0om7w==
Message-ID: <3f2e8d7c-6029-49ef-8e31-a3eb5efb385b@zytor.com>
Date: Sun, 11 Jan 2026 20:01:02 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT PATCH 04/19] x86: Make the 64-bit bzImage always
 physically relocatable
To: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>,
        linux-hardening@vger.kernel.org
References: <20260108092526.28586-21-ardb@kernel.org>
 <20260108092526.28586-25-ardb@kernel.org>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260108092526.28586-25-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-08 01:25, Ard Biesheuvel wrote:
> On x86_64, the physical placement of the kernel is independent from its
> mapping in the 'High Kernel Mapping' range. This means that even a
> position dependent kernel built without boot-time relocation support can
> run from any suitably aligned physical address, and there is no need to
> make this behavior dependent on whether or not the kernel is virtually
> relocatable.
> 
> On i386, the situation is different, given that the physical and virtual
> load offsets must be equal, and so only a relocatable kernel can be
> loaded at a physical address that deviates from its build-time default.
> 
> Clarify this in Kconfig and in the code, and advertise the 64-bit
> bzImage as loadable at any physical offset regardless of whether
> CONFIG_RELOCATABLE is set. In practice, this makes little difference,
> given that it defaults to 'y' and is a prerequisite for EFI_STUB and
> RANDOMIZE_BASE, but it will help with some future refactoring of the
> relocation code.
> 

I don't see any reason to support non-relocatable kernels anymore. In fact, in
a patchset I am working on I have already removed it.

	-hpa

