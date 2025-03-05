Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA981EA7DB
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177469; cv=none; b=k+lGFykwNCNvhmT4QE7o5k1HVR+b7GdxPbIWRUv2dTN97ZGQRa0aXdmOso3Gr0S5sdF1Um7lQ9IxpnF6cHePkkM63JD4zg4oof/5+fde0/ExIdYkSSkiDaSL2H+F+9gmrSH0MrwUaKSH/i0IwBsVjS6X7+8pxhYOok9obVtI0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177469; c=relaxed/simple;
	bh=Wba23t8y4zeAzzGOgYyj3RMEi3ZmOBs6WmgEB1JM6xs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pI8gKLkM91ns3p+Bl6Pfqg5fCyZqZ+cfIwnE0NoOWMeNXEO4yEkPKNX3P/HxeY6mXjbwuQXG4UBGIr2JbbpSV5+uaqhB7zh4jNueg7czGM+Jm6wu5m0ZxSsuJZbug/e3DKUafM9xqsE0QNbw80cpmyYkjQcGOjkt3SNohw94W/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iX+VRdPu; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iX+VRdPu"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741177464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaXpS2qkRKWHzM6dsXV1e2J5mXqRVuhX+G+d5r7JJMk=;
	b=iX+VRdPuH9ACyHY1AGshnkdwBKtlzIS2BUu9J8U03WQUDacjSygQIZ1GncW2L7PPMp5xu1
	DX+o00cUrv0E4qkO/QfEOc4h8Dzia4w0KwbAI/kwOQa9Dxm/RBqKapSizeviuDpbmWGoEg
	2xBpIPVfF1D3KhYHTKOHTL4pZLoaSdw=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [tip: perf/core] perf/x86: Annotate struct bts_buffer with
 __counted_by()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <Z8gvYIYXMHRC-btB@gmail.com>
Date: Wed, 5 Mar 2025 13:24:11 +0100
Cc: linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0921EF60-73BB-481C-AC5E-152470BBAB79@linux.dev>
References: <20250304183056.78920-2-thorsten.blum@linux.dev>
 <174111554764.14745.14213573362217486017.tip-bot2@tip-bot2>
 <Z8gW1rihV0aIp8Oo@gmail.com> <04A79410-77DA-40F9-8904-44DC2DE1E810@linux.dev>
 <Z8gvYIYXMHRC-btB@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 5. Mar 2025, at 12:02, Ingo Molnar wrote:
> * Thorsten Blum <thorsten.blum@linux.dev> wrote:
>> On 5. Mar 2025, at 10:18, Ingo Molnar wrote:
>>> Actually, on a second thought:
>>>=20
>>>> - buf =3D kzalloc_node(offsetof(struct bts_buffer, buf[nbuf]), =
GFP_KERNEL, node);
>>>> + buf =3D kzalloc_node(struct_size(buf, buf, nbuf), GFP_KERNEL, =
node);
>>>=20
>>> Firstly, in what world is 'buf, buf' more readable? One is a member =
of=20
>>> a structure, the other is the name of the structure - and they =
match,=20
>>> which shows that this function's naming conventions are a mess.
>>>=20
>>> Which should be fixed first ...
>>=20
>> Yes, I noticed this too, but since buf->buf[] is used all over the =
place
>> (also in other functions), I didn't rename it in this patch.
>>=20
>> We could just keep offsetof(struct bts_buffer, buf[nbuf]), or use
>> struct_size_t(struct bts_buffer, buf, nbuf) and still benefit from
>> additional compile-time checks, or rename the local variable to =
struct
>> bts_buffer *bts and use struct_size(bts, buf, nbuf), for example. Any
>> preferences or other ideas?
>=20
> To clean up this code before changing it, so that the changes become=20=

> obvious to review.
>=20
> Please also split out the annotation for instrumentation, it's =
separate=20
> from any struct_size() changes, right?

Yes, I'll send a v2 with the __counted_by() annotation and submit a
separate patch for struct_size() and other changes.

>>> I'm also not sure the code is correct ...
>>=20
>> Which part of it?
>=20
> The size calculation. On a second reading I *think* it's correct, but=20=

> it's unnecessarily confusing due to the buf<->buf aliasing.
>=20
> So in a cleaned up version of the code:
>=20
> - If we name 'struct bts_buffer' objects 'bb'
> - and bb:buf[] is the var-array
> - and we rename 'nbuf' to 'nr_buf' (the number of bb:buf[] elements)
>=20
> then the code right now does:
>=20
>       bb =3D kzalloc_node(offsetof(struct bts_buffer, bb[nr_buf]), =
GFP_KERNEL, node);
>=20
> ... which looks correct.

If bb:buf[] is the flexible array, it should be buf[nr_buf] like this:

	bb =3D kzalloc_node(offsetof(struct bts_buffer, buf[nr_buf]), =
GFP_KERNEL, node);

Thanks,
Thorsten

