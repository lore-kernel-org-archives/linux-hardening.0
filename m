Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235890;
	b=KXYkUoH9eQrL69jQDAkv8kijSYVFcESjlJbDj1mPYF6cRzj7ME7UMucvuVErGQGNiy2B
	 cFD0DHTk4O37lej8S03GMvAoPhq4sVWYio46Kf/3i0csSgfHtbwDOBohiqr0iCXcDaQu5
	 MdssHxCgQhZuE0FTZw7UALzJWB1AP7HNdXiwWoedjXQjKi3HestbU4isw2+WSym4/skIm
	 O19YN8AOZn7T0CBbDVPSCL0QLLz5FnBD5kWI8R3ZheFLbCJ549jiABu82Kf5wiOwy6fyb
	 0ly9sPXweL80fTNJT8Nq8ZALKyZF3cNjQuzfTFeIYcsmkuY4r5d4/2OveRBadNJfRoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235890;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=IXFGnVOw0X676vSQw1hYVt1+yXWOOSXyM9zBTmmxqGc=;
	b=sOZKpNYuz4tdcfMY3oEyZNWrz7PAqjzl1f9bKm8jD58sth8XYwy7TVRaOtJSWOkiOb8O
	 Gml9nS51y8z0/Ldl4ilJSSsL9Qb8DDkWcqHrl3ZfXwkM2jTiMXGiPCoPzuaXuBzpLpwA8
	 cFqQnjLdonsijeU+110iUo/UxuB8Ny0hOXR1lKsSL5Qqv6PqOGgXsz6jtRfPdqNYf0p9D
	 T32xnblvC39eVGRchlqiDACXhJcyAZ0DWJruj0XyXN5gA1u0FHJfqOQE5M5KWsvmBJ3Dm
	 PI4FTo5FhK40NQOI1qE8MXfXw579L6J2ljm1ko5U7oNlIp1w3ffQdXilFQfRmpO5ouQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=LIjHcQ4x;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4B606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 01:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61B4B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=LIjHcQ4x
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D1893801F8;
	Thu, 29 Oct 2026 01:04:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 1CD172000E;
	Thu, 29 Oct 2026 01:04:46 +0000 (UTC)
Date: Wed, 28 Oct 2026 21:04:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, Kees Cook
 <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: seq_buf_str() silent truncation (data corruption)
Message-ID: <20261028210444.295bbf96@fedora>
In-Reply-To: <auJmkx1p3nIrYeJ_@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
	<auJmkx1p3nIrYeJ_@devuan>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: jfbb6hdqihowiepggcaz5as7aparf8jz
X-Rspamd-Queue-Id: 1CD172000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18QpaLghy+lZEalie58RQd2SMZcwnpw1qA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=IXFGnVOw0X676vSQw1hYVt1+yXWOOSXyM9zBTmmxqGc=; b=LIjHcQ4xtQ6p+gflxQmx0+hQs/TA6q9LPuuBEBDyoTOFGtZizPwT1zNy/OLFiDV/uKc73RZ6BQ/1m0UaN4xKbxsLH/mRbHsi1JTyibNZwaSX4dmspKegExhcFkc7jBGoRA5BaPw/rFx/6x7NMbrYZsTqJQYAsjZuX4Aagbbtb10=
X-HE-Tag: 1793235886-830231
X-HE-Meta: U2FsdGVkX19kc37UKzl22pVigiyJVigIvYUnb3sYy5WAw/NF9xMDxAhwPXvHtxj+nmQ5tfyBOZDXRQ+TadMwUFEY+IUg2dtSxr9Rlp3Gpo2YiHrugopX11nHi9Ltvhm+m8VBcaTP8FCtK+5VevEEUp4x5/yzMOLX5MAgfTeCBg8MX8CoTps0LZR4b4Wf1JBj68nvH87bwd3/Njf2xaxmvRf0+F3F6/XySlnzHmvbOSE86L28VfN5X7OXJAMcZgXJRLciy5EYKMqdKjf72z3Ji51LDTtIpS4oVaySa6FNcFJo15e3QasSoheI3jFH2uD0Cvx+BKKo8LpoavAhE2i4gdwUx/WDh8Zd

On Wed, 28 Oct 2026 22:30:38 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> Let's see the implementation of seq_buf_str():
> 
> 	$ git show v7.3:include/linux/seq_buf.h | grepc seq_buf_str
> 	(standard input):static inline const char *seq_buf_str(struct seq_buf *s)
> 	{
> 		if (WARN_ON(s->size == 0))
> 			return "";
> 
> 		if (seq_buf_buffer_left(s))
> 			s->buffer[s->len] = 0;
> 		else
> 			s->buffer[s->size - 1] = 0;
> 
> 		return s->buffer;
> 	}
> 
> The first check is fine (we don't trigger the WARN_ON()).
> seq_buf_buffer_left(s) will return 0 (it returns 's->size - s->len').
> This means we'll execute the second branch.  That branch will result in
> overwriting the third byte with a '\0', without reporting the overflow.

Yes, Kees and I already discussed this:

  https://lore.kernel.org/all/20261016145928.16eddc9a@gandalf.local.home/

-- Steve
