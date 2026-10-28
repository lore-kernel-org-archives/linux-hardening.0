Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209680;
	b=eFoMlTuqQb8JRO/Cj+8X3JjDBVL75NsfaoHhPJBOz7KMeRkK3hDtZYaa9l0tPnP5LY9/
	 r4lw3owhidYsib0QaHwjqMc7Q1ZAZa1ZX9b7zr1JuqTXWudSRKzADxfuV/bZNHbID8Tu/
	 s1SOtr6TOpj/Hj7+j6rvVhBWkrBhRwDYkRNfI59Qe/u5CujazlbU1WsHAexmeVngxHqwi
	 kAa1nBIjKGZJaJVhTN7RUBoJxt9L5Nyekjkk/C5TTgZ5fa+hwzGjvsQSbRsNExlZ4KCXx
	 t8fiLfBGKo46gi6XMPPrSU6p2ukBqjbD94vrKK5ZMSyfbU3xQd3RHOWI2YP7qjn1b1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209680;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=RtPgMNhqupyWVsf8g5F2JSW0VnhMO36ohWkyC5M+pL8=;
	b=hHAOw0F5u0BZL9h7XtHEEI2yuWrELpLxcdTPe9w7lgRi4tdaxmGxms5X07oNMUiXSRpQ
	 zZJGI5B384m4Q70W+pIvPQ6uzPJq5lMVdKTwkC5v4xGQK+BU0q//2WwJ30OzHjzK6J6BH
	 IlWaGBs8ias/5PLul1ATzuk8X35e2daxyVjolX70wLXvEhr9yC8b96Mlpl5qn8FWMfNR7
	 WT3M9kgximozkXl2hVJb7PRxGGpXnXMO3W2DeC1xFB0a6mlpCWTE2TeykromtUAUxip3P
	 WKfr6CLHm+sw7s6sx0bJvuuCF15xO40fVv2SIeOtjJqhuyKusRKWNDcckwRGOniwI1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Du+MnRMC;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20F606A31C
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 17:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC20F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Du+MnRMC
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 813AD401C7;
	Wed, 28 Oct 2026 17:47:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 8E10F20025;
	Wed, 28 Oct 2026 17:47:56 +0000 (UTC)
Date: Wed, 28 Oct 2026 13:47:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, Kees Cook
 <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: seq_buf_putc() and strings
Message-ID: <20261028134755.176f8323@gandalf.local.home>
In-Reply-To: <auIrUV7A8eF8DCGG@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 8E10F20025
X-Stat-Signature: kzujxtrsicqo14unx44t4ohyudrduatt
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18+72OTEEFGF0VD73BioXiRqvn/78+cOwA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=RtPgMNhqupyWVsf8g5F2JSW0VnhMO36ohWkyC5M+pL8=; b=Du+MnRMCNLMhHyExW52g3zNPJEGkDU2IuoH//Sm4tmXRHWkECEM7thIl1wDj0wszeBuoSaWa9eoEA77iqqDof4zDSNOe/KGVzJah5nZuhX9zPQADWaKOZQxXbync6LbYGObKrsOUB1NoUuJEfH3sNmXQQqPIGYHsweJtxgVkKpo=
X-HE-Tag: 1793209676-311566
X-HE-Meta: U2FsdGVkX18GAd+vw7ieM3UVYV+oANDrR+c0Pvj2Gpu38FiXBJWBV6vUqHWnMumfUMWU5hlR7IuJXidH3KWF3u+8x0RaxB8okNAUjAPSRCpuPN4zr4ArGCS/4qZ2CYZQfwlpzfzDJQiA+WTY3yrrZrXcwBdd+fdGU0I3/zvr0cRrisxUqiF4YgcpLLm+G/bViwkPv6Lo1W+XY94wYCRQGT2ZyS3q7Z9oUJ1ckKtkUytj8JAHQcmFcCKl7tdexrxA/Ih0qBUQdAxsdNUP00ctGECne4vzIFqFLFBAsQkXTbP0BWAV25DwBSLaRf0LpcUMrqc2e5Bj4YOH3DifEUDO8cL4wSycgt9Q

On Wed, 28 Oct 2026 18:13:40 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> Are there any reasons to not write that NUL byte?

Yes, for speed. seq_buf is used in hotpaths in tracing. I purposely made
the design decision that the seq_buf string is never guaranteed to be NUL
terminated.

-- Steve
