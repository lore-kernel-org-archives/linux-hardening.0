Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06542505CA
	for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731608; cv=none; b=QMC6RP1egi9No+SmjGxl5wUcP6FNrXn5NqGJj4MJYcPhjaZcfUUlsDeVq+pLYsFbabykYF+tGUtCGnN9tYaXWqbNk3ycABxBQ4FdW/j92DmwoKLZ672LsFiUYEE3HfGcZA5fw5WFzGu/IE3LKpSJMsG+Y8mX58ZN1eER3arqc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731608; c=relaxed/simple;
	bh=cu6AH0LorBeaUl23UBb152wb7dy61G0HE3t3ldDL6Js=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=P6cUcTUBe+gJsWZ6ur7P/qWVbSU5nIIL7kef9ZXQ04Ck5XK9moq2ruO0w1Mi87R1+rCnZtngKPbal/Kp1ANQC9qZgK8XN13OvUPRSw8Hh4HXJoaXgoFnvyFiYtsXgo0vmNpytQ+5Wf3m48Tk7aSXMh0PtHdFkYpfqSzpJ1zPLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iXbd+x7d; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iXbd+x7d"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740731597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtPhv23CDdC3cqvO+SDmiWTaamG+eaLu24Z75QAy0Dk=;
	b=iXbd+x7dggLGloIEF1pPuzZPzHoGCj+/7KP4rppWrmw8N17BQfVammHDPZLo3LRMcIcyut
	jx8Ys2HrTHgF4FscyQcpVzckPPSwvU7OT1OGt12zuB8iG9nbad//8L9niHPoDNpEGOFMc+
	/E67p0mCF1+FlcKG+ifHWQicatMNSZc=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] hwmon: (pmbus/core) Replace deprecated strncpy() with
 strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <25793e9f-211e-4e4e-86ac-88e3b902fb68@roeck-us.net>
Date: Fri, 28 Feb 2025 09:33:04 +0100
Cc: Jean Delvare <jdelvare@suse.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Patryk Biel <pbiel7@gmail.com>,
 Ninad Palsule <ninad@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 linux-hardening@vger.kernel.org,
 linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4916492F-AE8D-4153-B268-39B86A8CF57F@linux.dev>
References: <20250227173936.7746-2-thorsten.blum@linux.dev>
 <25793e9f-211e-4e4e-86ac-88e3b902fb68@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
X-Migadu-Flow: FLOW_OUT

On 27. Feb 2025, at 23:37, Guenter Roeck wrote:
> On 2/27/25 09:39, Thorsten Blum wrote:
>> strncpy() is deprecated for NUL-terminated destination buffers; use
>> strscpy() instead.
>> Compile-tested only.
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
> 
> What guarantees that strlen(lstring) < sizeof(label->label) ?

Hi Guenter, I don't think it matters for this patch.

If lstring >= label, strscpy() behaves the same as strncpy() because the
size argument is now one byte larger.

If lstring < label, strscpy() NUL-terminates the destination buffer, but
doesn't add NUL-padding compared to strncpy(). However, this doesn't
matter because label is already zero-initialized.

Thanks,
Thorsten
