Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CDF1B042F
	for <linux-hardening@vger.kernel.org>; Fri,  7 Mar 2025 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347154; cv=none; b=YUroT6XO6RkDWsiorlF/oVLdgMrfmkvzWBg6yr0M3capFCHDXlnNi7vat27Lul0N8k/ulLrcshrKFiHctd34acbd46ygwD6ua1CS8fyNxWodfdiO53zmkowHwLQpBtgNAB6dKy+xJJQu72eagXePJJQ3lbAkimKB5Q8ee2Yno/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347154; c=relaxed/simple;
	bh=3Iuj/UuF/TJU5zn1g/GY0WjUU9EAhCYdV82WLriCjLA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t4Fky7ULw/t0DPg7u1QVMuT9NUrIdfZ0RBHgkuHgMlgs7lEEzIIRXPNY+YGeZYACOASuBAN4ZJ1FG++On64vaPRuPnsO32vFA1tGHfTovccuI8XgGQGtmL9rdPo3IbA67rD7j8JpYiU0ukttHaWj+/VfphwPYCmJfM4fEvjfwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MdWD0VSG; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MdWD0VSG"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741347140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCz6VOcj+sbYdT5Ib8iLUbl8DD9+/qwsrkd0xRQj60Q=;
	b=MdWD0VSG2UlL0gC7craEd99hr6kETrofjHs9baOSGl7Hu/mV/8WMw5cnc3JJktmck3pPjo
	Yk00avSgzghmNBAduuAUt3cb8xvtjuEo8QQrUL9ZKBhDV+K+M1zhAW2yxRiRpaNaz26Ixt
	eGvnEZfgQUPcCTvuy3y3IMmZCkpqMbE=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] mux: Convert mux_control_ops to a flex array
 member in mux_chip
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <202503031040.223DEF2781@keescook>
Date: Fri, 7 Mar 2025 12:32:07 +0100
Cc: Peter Rosin <peda@axentia.se>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <785391F0-C381-47FE-89E7-6265F7761208@linux.dev>
References: <20250302230220.245739-3-thorsten.blum@linux.dev>
 <202503031040.223DEF2781@keescook>
To: Kees Cook <kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 3. Mar 2025, at 19:44, Kees Cook wrote:
> On Mon, Mar 03, 2025 at 12:02:22AM +0100, Thorsten Blum wrote:
>> Convert mux_control_ops to a flexible array member at the end of the
>> mux_chip struct and add the __counted_by() compiler attribute to
>> improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>>=20
>> Use struct_size() to calculate the number of bytes to allocate for a =
new
>> mux chip and to remove the following Coccinelle/coccicheck warning:
>>=20
>>  WARNING: Use struct_size
>>=20
>> Use size_add() to safely add any extra bytes.
>>=20
>> Compile-tested only.
>=20
> I believe this will fail at runtime. Note that sizeof_priv follows the
> allocation, so at the very least, you'd need to update:
>=20
> static inline void *mux_chip_priv(struct mux_chip *mux_chip)
> {
>        return &mux_chip->mux[mux_chip->controllers];
> }
>=20
> to not use the mux array itself as a location reference because it =
will
> be seen as out of bounds.
>=20
> To deal with this, the location will need to be calculated using
> mux_chip as the base, not mux_chip->mux as the base. For example, see
> commit 838ae9f45c4e ("nouveau/gsp: Avoid addressing beyond end of =
rpc->entries")

Since this should work and is well-defined C code according to [1][2],
could you give this patch another look or should I still change it and
submit a v2?

Thanks,
Thorsten

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D119132
[2] https://github.com/llvm/llvm-project/issues/129951=
