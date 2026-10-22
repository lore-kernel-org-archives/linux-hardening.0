Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700406;
	b=D3WHoC1Jn7iCvkZzGvRYkWyVSsJr1JErwet/oatfQX3SA9zUAnf74xRM4/gGpOA3fLrI
	 dWAc+J76wGPakatNcxX6ze2BpmARCu3RHzm2H62qbqq0tUsDJIZQiBj3qG1YG1zEpm6B2
	 b6vmPaYLnsP0pmS98VXngHZ2eoGtBxEGbFR+gxO/onArXlaaXd8o3l5eDVuH6PDeOiCxI
	 PKVWjZ4HzmwmotTB5IeUQgSobxLfviz1PfVjhCUVAu3OX7YS/ByhCWjQX/ehvkxS9KqLZ
	 QY4f4ya87HP8F21FO4YcO6vgwADsxHfzcohARRbewoOxMwTl+W8E7UU8ed57mXURVWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700406;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=hDGNj6FkCanQQ2IhMw7Ss/rx89Zl/6+sIi5NgumxwwM=;
	b=RVN3vXDUp2tDQLvuLDBQLWTkBBTSkDhM8uAq1xZORIYCbd68jxU0Ss6xID13N/58j6n6
	 RHrwXxJTImUFdDyPRxaHn1jEEbxtfaZpXxLXX9d6QVTAeReIQf9Ys1bZmRifRp28kS/DP
	 OyqAQ+gPJlm+Qo8uQUZ5XxLq6WlyDBuYFzOOY5fcqcvcKQ3TalegufQo8WQSD2vRsSLfn
	 +RLoSOIJFvT7t1XwZg9Ufl9312OeFazcl+kuQ47aCd+baops5pdC4255/4XzRDjd0D+Pr
	 hByFqAErkn5wXi0Jj2SgrpeOWQPsLIaOzA5U99HAGq0kmx2XqK1RePjI0x6Xi/7sN5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=bnFT8bTU;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA391606A319;
	Thu, 22 Oct 2026 20:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA391606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=bnFT8bTU
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id E88ED1A022C;
	Thu, 22 Oct 2026 20:20:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 8C9F520026;
	Thu, 22 Oct 2026 20:20:01 +0000 (UTC)
Date: Thu, 22 Oct 2026 16:20:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr
 Mladek <pmladek@suse.com>, Shuvam Pandey <shuvampandey1@gmail.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <20261022162000.18aa4162@gandalf.local.home>
In-Reply-To: <atptYsHyS6YGtzPV@debian>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-6-kees@kernel.org>
	<20261016145928.16eddc9a@gandalf.local.home>
	<202610221058.C5626C5172@keescook>
	<atpmAQ932J3_8IvJ@debian>
	<20261022155726.7f20c4cb@gandalf.local.home>
	<atptYsHyS6YGtzPV@debian>
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
X-Stat-Signature: 55kgt4ahuw3oexctuuywkqa8ouaskjms
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8C9F520026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19GOhrAbK0zI6qqraTTrKkUil+PVjA63Fo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=hDGNj6FkCanQQ2IhMw7Ss/rx89Zl/6+sIi5NgumxwwM=; b=bnFT8bTUxJGzFLINvIbSkb3kfuenXBN7DT3+EARR/UQnruwvhxBsSQ5tTMNHJr8SQyYuTKN1150+E8+IYtx77agdAf8sKjIWdyWw8fZWf0f94iidUDXw12/KllYUF4juDTXguyu7tPO7927fZb/Q9NxlvQwmnHobV8bGvtz1xJ4=
X-HE-Tag: 1792700401-645610
X-HE-Meta: U2FsdGVkX1+qUfP3xwYqc/F0G+4fL3WqQ+nGJyPoJDunTH82aA2AQhhfx9qlxkswq+km2n2pUMbZyMU8nWU57EXMBA+LqH71DXs6BAjrsHasmmysykqCpi+D9g7hCJ9F1U/3xX9JeTyqR53VYvAuhSR8NNddqIgyhPuFAvZH1a3InlHqJ/lJlf9LMu7u0OWf/mLJhn2Ko5HfcrROXPM0t9d2AcZnyrCij7vPghIbuLxMta3Qkfo15eu9AnV2Rnk8Fu53O9I5CYznv57cOIN2mNzDEF/ATjp4duPRTVLuLT3uXs7FqUQi5vqkQzVrgdrL19KuUSb7i/KGt4PYQ2r6Ycx6i8sskGNc3G9NGkuhmmWjcZwbXLOx+w==

On Thu, 22 Oct 2026 22:11:27 +0200
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> Agree.
> 
> But still, a better design would do:
> 
> 	static inline void
> 	seq_buf_set_overflow(struct seq_buf *s)
> 	{
> 		s->p = NULL;
> 	}
> 
> This is way more robust, and also easier to understand.  My head is
> boiling when trying to review this patch set for correctness.  That's
> not a good sign.

But that loses all data. We still want access to what was written.

-- Steve
