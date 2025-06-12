Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733E298CB2
	for <linux-hardening@vger.kernel.org>; Thu, 12 Jun 2025 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744561; cv=none; b=lMh5SUorSiDBlzAGjuLKh6v1VdzU0wP1Ex3gzN3N92rJRqmZDr6DCnxr4iQofvul9GpBh4U9KQXhnEeYb4Uf0olzaCRWG7NeRAZVnSMnVR++o1jIRS7NtPopLXD0LMOcM7fWoYZyyKL7qVNEi/6cmtfof0SfYf99gzc3Wdh21PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744561; c=relaxed/simple;
	bh=P/JRd2lHPGhDT3im61+UOLueNnXqh0lkxE8BtPD0PYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBDplJPycuj4y56iLTfdLBwMzB4PsIs+FQjdboDsUdmX8e6bvuX04ZShpuEccG8vodARG7mwdqphMcFe3Frn+/QoHQbepYJ3nPdWAwVA9dxXKF8Ps0mq8qSXSrm/aDHAPz4qVk9T3A+Ots3etvmfop4hVRUZnWmKj1ardvzdJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=ybcFJJih; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="ybcFJJih"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bJ6sl126cz9tJR;
	Thu, 12 Jun 2025 18:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1749744555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=geyoIOufnNyL2QORApZMSyBSnDHoOLrbH0b4kuCOKOw=;
	b=ybcFJJih7D/IT5O/wPsKKWJ/ydLa/CH1tbqS1yTFezbtu/x/Gk/Ukz1HABfykXqLk1xH7r
	Q29kOWiRnS20CWxhwbUpiLf5yZ4L7PZeXmJq8AsQfraNqgF3GLkbT0vPRWwiOWgkGdhBK2
	Z2aukNMRIOQDNz5A7xMU5DZwAFuD5pL1QkOcFTpeMrVzAcAJMODZaP1lGat4Le2KJgOK/8
	OtGFlCR8JwBqGx2i9FbQ+ZIICZXvP3bD7hufR7jrZO+f/l7xJ9+EfJsmGOEqoDyJar/pOU
	BOf3XPL4QySy6xgN6U4qZmPIL+uALdP0IR4JKUgnxE+0+pDtkOUNgemJZtEb7g==
Date: Thu, 12 Jun 2025 21:39:10 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, justinstitt@google.com, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org
Subject: Re: [RFC PATCH] um: replace deprecated strncpy with strscpy
Message-ID: <apa4k3ikv5huxms2dyf2cduhkg73gt5sei3skg7kxcrew6v6py@4fxolyigqe4e>
References: <20250607213006.7858-1-listout@listout.xyz>
 <202506092114.01147457A5@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202506092114.01147457A5@keescook>

On 09.06.2025 21:15, Kees Cook wrote:
> 
> I think we need wholesale fix the kernel's usage of
> strncpy_from_user()... first, how is it being used?
So I looked at some of the codes under driver, but it's not very clear
to me how they are currently used.
For example in drivers/tty/vt/vt.c there is this code

	if (!op->data)
		s = NULL;
	else if (strncpy_from_user(name, op->data, MAX_FONT_NAME - 1) < 0)
		return -EFAULT;
	else
		name[MAX_FONT_NAME - 1] = 0;

Which looks like it's not getting NUL terminated.
Where as there's also other instances such as in
drivers/accel/ivpu/ivpu_debugfs.c


	ret = strncpy_from_user(buffer, user_buf, size);
	if (ret < 0)
		return ret;

and in drivers/gpu/drm/virtio/virtgpu_ioctl.c


	ret = strncpy_from_user(vfpriv->debug_name,
			u64_to_user_ptr(value),
			DEBUG_NAME_MAX_LEN - 1);

again in drivers/dma/xilinx/xilinx_dpdma.c we see


	ret = strncpy_from_user(kern_buff, buf, size);
	if (ret < 0)
		goto done;

So it seems like it's not very consistent to me. But I might be wrong.

> Are things being
> manually terminated? Are something destinations not actually C Strings?

Some of them are, while others are not. For example in
drivers/dma/xilinx/xilinx_dpdma.c example the kern_buff is a pointer to
char while in the drivers/gpu/drm/virtio/virtgpu_ioctl.c example
vfpriv->debug_name is an array.

> We may want two APIs (like strtomem vs strscpy). And then since we're
> dealing with user data, I would think padding should be included?

Can you please example on this a bit, like would you like two separate
functions, for example strscpy_from_user and strtomem_from_user. For the
padding we use _pad version of the strscpy function.
> -- 
> Kees Cook

-- 
Regards,
listout
