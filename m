Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448622F5A1A;
	Mon, 12 Jan 2026 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219657; cv=none; b=XhXcRsxZbZPM0ZiOlSbXLueXmM6JsS0OKBMudlcGu/b+qeBebvJllDTRTx1zEIZHOkF8jWgcPBfgCYLkMATXlPJpqE6MfOAYsdSUGb//vJ/HqVTMvpNiewrN8Bc0XVpf/r3lQnc7Xg7yb9LP4gdMjrVnh1sVkf2jPeO/StxNPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219657; c=relaxed/simple;
	bh=tKJ8EDq4hyO9AfeKyEDudrJUogYLnmYlcaBZEU+u42c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gw8hlqn8CKWdKUxHPjqeEm4tcdq6tVv9qXsKdFpfYUDdqW7aEZ0vEq/M/Dn+kB55dwtD4AiHt5W2aIEsPE7Yf6b7JtwN0zNVEtBWzSBs9iM3Jg4dm+Ytf9xqYXvu5yVT5mhQ/sUU12hyPG2rFUVvl/gmAkSg+15CosHmGVj7Unc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DO8Z/JkF; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DO8Z/JkF"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60CC6xQs2138474
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 12 Jan 2026 04:07:00 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60CC6xQs2138474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768219621;
	bh=8w8Yf25k/xbVuxmaBEr1voG9vNuzE/WuhThoLNwL46A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=DO8Z/JkFSYVbjS5zUCknTK30Ahxbo7bkPGf22zRu3WPf6C4Czx+Bcn/OqmfVDeF7C
	 VRZhJXf4/8TAjD38hZaJoydL5v4mXb4E498Y2oSdRlgJrmy/nK3ACfmvrwlN+2K3Lu
	 Up0bLALF7nXgE3rZtMkN+YqpMf45KUV0Su5e9polyNwhrFT43hsH0kiZnfMMu7w6Md
	 reb5UXixVSnln+b4YjxYwRNih7DSBtggOo1SQBm6pcP1GYCxuIjXshYwnBQ/+zynWu
	 43mpZf9sMHMxk9BFKVxkvN2YaD7RQKhU73V14VtNf4YYxDsX1C4fBGkL2KV8OCl8Bq
	 tm/8+Hc/aNwdw==
Date: Mon, 12 Jan 2026 04:06:58 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>
CC: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>,
        linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC/RFT_PATCH_04/19=5D_x86=3A_Make_the_64?=
 =?US-ASCII?Q?-bit_bzImage_always_physically_relocatable?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260112104746.6521740c@pumpkin>
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-25-ardb@kernel.org> <3f2e8d7c-6029-49ef-8e31-a3eb5efb385b@zytor.com> <20260112104746.6521740c@pumpkin>
Message-ID: <532BA26A-7477-4F1D-B8BD-84EABFB4F91C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 12, 2026 2:47:46 AM PST, David Laight <david=2Elaight=2Elinux@gm=
ail=2Ecom> wrote:
>On Sun, 11 Jan 2026 20:01:02 -0800
>"H=2E Peter Anvin" <hpa@zytor=2Ecom> wrote:
>
>> On 2026-01-08 01:25, Ard Biesheuvel wrote:
>> > On x86_64, the physical placement of the kernel is independent from i=
ts
>> > mapping in the 'High Kernel Mapping' range=2E This means that even a
>> > position dependent kernel built without boot-time relocation support =
can
>> > run from any suitably aligned physical address, and there is no need =
to
>> > make this behavior dependent on whether or not the kernel is virtuall=
y
>> > relocatable=2E
>> >=20
>> > On i386, the situation is different, given that the physical and virt=
ual
>> > load offsets must be equal, and so only a relocatable kernel can be
>> > loaded at a physical address that deviates from its build-time defaul=
t=2E
>> >=20
>> > Clarify this in Kconfig and in the code, and advertise the 64-bit
>> > bzImage as loadable at any physical offset regardless of whether
>> > CONFIG_RELOCATABLE is set=2E In practice, this makes little differenc=
e,
>> > given that it defaults to 'y' and is a prerequisite for EFI_STUB and
>> > RANDOMIZE_BASE, but it will help with some future refactoring of the
>> > relocation code=2E
>> >  =20
>>=20
>> I don't see any reason to support non-relocatable kernels anymore=2E In=
 fact, in
>> a patchset I am working on I have already removed it=2E
>
>For just 64bit, or 32bit as well?
>The 'bloat' for 32bit will be higher due to the lack of pc-relative
>addressing=2E
>
>	David
>
>>=20
>> 	-hpa
>>=20
>>=20
>

Either=2E The bloat is strictly boot time=2E
