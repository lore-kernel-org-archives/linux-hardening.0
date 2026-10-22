Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699083;
	b=B8ODna+5hIUI5F0Gig0Y/xL6LvUzVVFy/1Qpw/uytfKGYuCFKk4irFFgR3W/rKe+0IBk
	 vYrwC2Bpkdnvhxu/uX8CDEesfT41mqs6CvUY+Sl9VB0lzy+Qz4vxr2rI0tqL3o4yUfW82
	 3+yy4TZKadrb6FW25gHjb/OKqoJBWiykzw6EOY0EANGzQWz4E8NyWHlT1JHw/F4OjvTRo
	 nqOpaNnz76bAh3doLIDDYMqwr9/TzM/CM+8CeFwmS1nhTGMtJu4Z+syIw1Tsl9RPNHokG
	 /4GYg2GKduuiRbMEH/ckyYXgeQviSx8bVcMN7051zEHvUhAbwhuhFWxdnJZQTBjtk7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699083;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=VI+NV0TNkbDNGiblHPkmebs0ziDZ9xUFKlBjpmJW0rE=;
	b=XnuOtPUal/+7bu+ZmIa7h/wyzhOQK6WJHlFXtCca4mIU+VBxH/xZi4xiJGWxPQFjbaTi
	 E2hHuG+/7/AwXG1Xg3vhY+lmJ5o2kltZJR5si/9j37GQTcTn8YP8QwWQoKYbiHA7ScJIZ
	 33Adb4tbr20Cw0ERsWRKNSas6uCudQELHOkSoafG4uDxxwBrNcrgNWwX+1hQ4oco+uHCb
	 l2Ep6CaKxManslam1ezrtulmzjgkaGetUbqBqBpd79OdBRFYGx8pmFbv38nY3D+WEoQhi
	 ioeIRP/vwpYj/b0/NE+WHEjBnzcMUfT5fe4wz6SITvfXYxBjfyuhpn30gQkSJ0/0vlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=gaMtE4Ys;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE3606A322;
	Thu, 22 Oct 2026 19:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3FE3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=gaMtE4Ys
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id E1DAF1601B4;
	Thu, 22 Oct 2026 19:57:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 9CFE318;
	Thu, 22 Oct 2026 19:57:52 +0000 (UTC)
Date: Thu, 22 Oct 2026 15:57:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr
 Mladek <pmladek@suse.com>, Shuvam Pandey <shuvampandey1@gmail.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <20261022155726.7f20c4cb@gandalf.local.home>
In-Reply-To: <atpmAQ932J3_8IvJ@debian>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-6-kees@kernel.org>
	<20261016145928.16eddc9a@gandalf.local.home>
	<202610221058.C5626C5172@keescook>
	<atpmAQ932J3_8IvJ@debian>
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
X-Rspamd-Queue-Id: 9CFE318
X-Stat-Signature: 8gn4uiryjeka1okszcwwst5zfwwbu3j7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Uh2IxHyKohheBsfsQ3Px4GP42KIGNVsI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=VI+NV0TNkbDNGiblHPkmebs0ziDZ9xUFKlBjpmJW0rE=; b=gaMtE4YsIXXy6KQOOqEJ0UAPSpjJ4SUEFihfjfjLE1xlKJI3Pihv9lfyUa7mf29iEsYKTJIur6OapVEuIB34OJrpaTW/IbQXsKz2TbSFjQG21SsZEWsIcJO+zgGGUJU52wqa/hF1gYhEIpW2Xz7zrpQ1WSWE/eRnaNP3OzUC9J4=
X-HE-Tag: 1792699072-699895
X-HE-Meta: U2FsdGVkX1+SWGji/JmWRDM6OSMLmYvi/YeoMZGTDRKcjBQSpYbxqC3QpW0abbPgd81xhPd1jWF0WzaGZcS/sS3clc3ss2daYginP8DJZmBV29tTiwMbmGysYEKnDo4qiJZS+6i4ccGDKfj4LFxFh3ZllUZsPyvjTm8G3/hWh+RlN8dyYXlqOX1KkMX7uljpGY/XsJioaVWwJyjfUY6MesgsRkgNi3UDkmeNanM2W8Oqdsp/onczSgm2b4ayZ/J4+xYk0NlHk8UWaPSB8LDSMBLjCCFM6AIfxW882PdJRRYG9Sm5bCcS/tMhK0w68n+NZCw51DAt3VTTBwjOHfAwPoSp4Ee/P8QR

On Thu, 22 Oct 2026 21:41:53 +0200
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> > > Hmm, I just realized that this could inadvertently overflow the buffer. If
> > > len == size, it may not be overflowed. If using seq_buf_putmem() and
> > > filling the entire buffer, calling this would force an overflow as we just
> > > truncated the last byte.  
> > 
> > Hm, yes. So the "else" branch needs to include:
> > 
> > 	s->len = s->size + 1;  
> 
> Please think again about the possibility of using pointers instead of
> lengths.  This is a source of off-by-one bugs that's only caused by
> the choice of data, I believe.  If using pointers, truncation would be
> stored as a NULL pointer, and off-by-ones would be less likely.
> 
> Consider this off-by-one to be just a sympthom of the underlying
> problematic design.  Whenever a design forces you to write +1 or -1,
> there are high chances that the design is sub-optimal regarding safety.

It's not an off-by-one error here. The s->len = size - 1 is correct, but it
also has a side effect of removing a character without marking it
overflowed. The seq_buf defines being "overflowed" as s->len == s->size + 1.
What the else statement should have is:

	else
		seq_buf_set_overflow(s);

Which would be less confusing to reviewers as that is defined as:

static inline void
seq_buf_set_overflow(struct seq_buf *s)
{
	s->len = s->size + 1;
}

-- Steve
