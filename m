Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26E1A76B1
	for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263815; cv=none; b=RO4fFVYoPE0wf5TTl+i5r/kouc69sR8btjICydDmMzlXbdI1oLWdFOHkuemDCEUt717YWEKr2X9Wu8rmIhqjZQdwD8cp6Lm3yeZdw4rrHQFbwtgCCTJyhky/GwwGg068LLCmvVQjfManukNLxpm17uef8JLK3xFXPp+KNMGER+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263815; c=relaxed/simple;
	bh=bgfj2m6LPQMcGtZYXMhupZjoTd0XkWjInAECH+rbt+I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Tr1e3G33phLGCU1NUS5JnE4fe6Ahl6FyA5kiNVgi5fSOL4676VdwGux0+Uo/jYhiBAKp2XN+/JRENRIWMp0ctoLP8WlEEJUwAJAJNYv0gLnlPLjga0xbYPkRPx3Zeih0kmkzLDMDGesQSRGLxjsRp2DYgMdydBEPMDrh5FEMbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bcRSdr6Q; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bcRSdr6Q"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755263801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chldCKJKzLBEudA2zF+CVszcShmDJjYf2nSfYDWW2g4=;
	b=bcRSdr6QfLQd4sMbwYOukohDy3hwJeheXOHA4MbgC/GFOg60IobTqhElaGdzcjEKwDiZcX
	8ja8pUCyXcXevtsccJIR9OC1VYxF9cQVyhxu+k0TQ5Ue0Gy7Bfid5kI3AGRhdT9753O19+
	/t/Q14kSllXD2ONitO2VLDZs7DnTPVU=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and
 memcpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aJ8cyXzMaa9b7ppN@aspen.lan>
Date: Fri, 15 Aug 2025 15:16:27 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Nir Lichtman <nir@lichtman.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 linux-hardening@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <72F30E3D-2887-4494-B58C-2042AC880C1B@linux.dev>
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
 <aJ72XZ0VkrCkKFNy@aspen.lan> <710CDE93-89CC-4B60-A582-5F9B2916ED72@linux.dev>
 <aJ8cyXzMaa9b7ppN@aspen.lan>
To: Daniel Thompson <daniel@riscstar.com>
X-Migadu-Flow: FLOW_OUT

On 15. Aug 2025, at 13:40, Daniel Thompson wrote:
> On Fri, Aug 15, 2025 at 01:28:01PM +0200, Thorsten Blum wrote:
>> Hi Daniel,
>>=20
>>> On 15. Aug 2025, at 10:57, Daniel Thompson wrote:
>>> Sorry but a strscpy() where the length of the destination buffer has
>>> been calculated from the source string is way too much of a red flag
>>> for me.
>>>=20
>>> Put another way if there are "no functional changes intended" then =
there
>>> cannot possibly be any security benefit from replacing the "unsafe"
>>> strcpy() with the "safe" strscpy(). Likewise abusing the destination
>>> length argument to truncate a string makes the code shorter but =
*not*
>>> clearer because it's too easy to misread.
>>=20
>> Deliberately truncating the source using strscpy() is a valid use =
case.
>> strscpy() allows the size argument to be smaller than the destination
>> buffer, so this is an intended use of the size argument, not an =
abuse.
>=20
> Sorry, I didn't phrase that especially well. I regard the abuse to be
> deriving the length of the destination buffer exclusively from the
> state of the source buffer.
>=20
> As mentioned, it would be much cleaner to eliminate the string copy =
entirely
> than to translate it into something so similar to the original =
strcpy().

Something like this?

char *kdb_strdup_dequote(const char *str, gfp_t type)
{
	size_t len =3D strlen(str);
	char *s;

	if (str[0] =3D=3D '"') {
		/* skip leading quote */
		len--;
		str++;

		if (len > 0 && str[len - 1] =3D=3D '"')
			len--; /* skip trailing quote */
       }

	len++; /* add space for NUL terminator */

	s =3D kmalloc(len, type);
	if (!s)
		return NULL;
	strscpy(s, str, len);
	return s;
}

This should probably be a separate patch, right?

Thanks,
Thorsten

