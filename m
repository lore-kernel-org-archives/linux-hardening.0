Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699515;
	b=hR1fAbh41RIA+DAGjzxYOVAvpjY6L70sfiEeHgnezevmonNPD5C4wvS8v+yTLPmHn5Wo
	 l6HnSWqangQuXY7GgzPgVkFlIQHQNXxoGCGtYyP+oM30BtFu5AEfAIWQKjtG0ZNOHXhTJ
	 QWdP+qcqdDnjNsJDm1z4Wc/PSzRgPG+MWkqKUOlxEI8++oU600pJYGKD57Qi7g7NgvWo/
	 IVII5iD4++kZYFkdClqxqamVzsaO+HMO6fyrNc2zxFySjWfRVkDbZ9jzOLK94lb6l+w71
	 RGJwhXme+OmipXQfoUHaMaN1F37TXH7IhzrQSKQAsXPbyhzcBI58f+fDlbBVnorXwOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699515;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=B7GYLdh5IOboTr1ysulRvF3slYyaIvJBLVGe2VBdbxI=;
	b=1ezX7ITkuNMa4yCvCloRpRjPDLZloQB6PSkZSAIi4zPlJCJtfrTY/GW308bcon5UveD4
	 In2KeBxLx/hxCF1Q6c/LOzkcSZab8hIp0lgFx4ZVyCoFFrrEgJ3GHvoCVdz34eRSB46xW
	 0DOoPjH9wtBvO7rYowIlTZtrm8erEhz4J8um/nwHecPodsBge9fn3lA9qk8iAEdTlC/he
	 28Onw6y/QCiNzjwUyRiWSAIb6mBKkCKXbfwK+02UHB6RwmLXPXfK2WJF4LS3X8T+xg4v2
	 RDzROnozdkM8moGKGTH1i4G9+Rc6NSMN77lzNdLBWRtxa6bNNR+J8sm8GgPzlMZjQjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=4yyadxw3;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AEA606A319;
	Thu, 22 Oct 2026 20:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55AEA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=4yyadxw3
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 1C63912022A;
	Thu, 22 Oct 2026 20:05:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id DD7D220029;
	Thu, 22 Oct 2026 20:05:09 +0000 (UTC)
Date: Thu, 22 Oct 2026 16:05:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr
 Mladek <pmladek@suse.com>, Shuvam Pandey <shuvampandey1@gmail.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <20261022160508.1246074d@gandalf.local.home>
In-Reply-To: <20261022155726.7f20c4cb@gandalf.local.home>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-6-kees@kernel.org>
	<20261016145928.16eddc9a@gandalf.local.home>
	<202610221058.C5626C5172@keescook>
	<atpmAQ932J3_8IvJ@debian>
	<20261022155726.7f20c4cb@gandalf.local.home>
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
X-Stat-Signature: w8gjnhbiokua9xc1yns4e1r5qygw3y4j
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: DD7D220029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/TEyWZHgu74ekruEIXRKnJ2PD1j8e1h7g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=B7GYLdh5IOboTr1ysulRvF3slYyaIvJBLVGe2VBdbxI=; b=4yyadxw333J2Xchpa8DJgHY+1z3VPFd8b/wqRJav0Uw99uj6aUZiZEDLmor8XBq/gf+XwppJvRR3Y+LQoQJTMuG64DeMfump2x26pMd2dTk2u92xE8iTZXTjCE+4Mfr/5rGT2utv6cLmdBFdSPvXx1eYhTsjLdX8O1/EPk5nHlc=
X-HE-Tag: 1792699509-922341
X-HE-Meta: U2FsdGVkX1+dIp5FMEqtso9v97C4uEAjZ1x8ctHVBdZLr7MdAQYzZQUOBPfDoTxruZnmEu2bDNa4RefHgozuKhHhBUnjkBazvj8dZWznzPCHGBtSRDQSDHbkuLORTjPqINsooaXCsUERHS6DwP2Y98qTVekjbrGjDwALxbIZJ13mX4cnmLPBh+gJ/lSc9JYCiGkgmoqUt5sNo9Vg8i3UCOGvRA+gZTJMUiMQM5AcnbxV7+Q/7n24BM+dpcHTMOXlDEO21pptzklP95JUjzpmqu8G2/VGjX7ilhFd1J3SnaKJKqfA8HpQgBPw7kx80MqgWZay36OoMxf0TnhR99Jl5Tp5tNGCblZ3A4OMvgg9uJ5k6d6+nXwnuR5ulWc9puJe

On Thu, 22 Oct 2026 15:57:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> It's not an off-by-one error here. The s->len = size - 1 is correct, but it
> also has a side effect of removing a character without marking it
> overflowed. The seq_buf defines being "overflowed" as s->len == s->size + 1.
> What the else statement should have is:
> 
> 	else
> 		seq_buf_set_overflow(s);
> 
> Which would be less confusing to reviewers as that is defined as:
> 
> static inline void
> seq_buf_set_overflow(struct seq_buf *s)
> {
> 	s->len = s->size + 1;
> }

More exactly:

static inline size_t __seq_buf_terminate(struct seq_buf *s)
{
	size_t end;

	if (seq_buf_buffer_left(s)) {
		end = s->len;
	} else {
		end = s->size - 1;
		seq_buf_set_overflow(s);
	}

	s->buffer[end] = 0;

	return end;
}
