Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284116;
	b=SiX+aTSG8cnvviKDpE0N011JFxFghFSEwix34GHCJToV5H1C8NbPLz5O36BhSg2gxIib
	 7dSJiKDMTRu7ZCj2MPds9iny2BEyDWaAd6vamuIm9n2m/67csvmYmjZktmStjnUvWwYx0
	 bgJiOuHjAdr2/vEjz2Dbjp+cCLrfcPUZOG+SsgpTQvtMdi26LIofqMB3VBnTU87u2n0em
	 jhZFbcdaT0Tf8oWyTqCIW8pY1bJkwsMU5iI+clh4OUQ2eDdvZ60WjVs1D/01EseRk1QOf
	 PpE6nH51yw0hlEGMW0uorXzy1YF+MZLQKZSOOLuiqwuFXQCvsrhShkk/UesJ8cvPkhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284116;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=5VhPC5qeUgmGYgtyWWv5WYGcjr0/h9lMvKlu7ZUl58Q=;
	b=Y0iWcljAnXvkG6Q/47QhRH2N2HHr9C4UF0MYWjvb4L1YyTbZWhmM1EoHMpAFmi1NLD+0
	 cM9poTu1xvzwkEKbnhmYVW9MlA5wds6XAFUFcthgnHo2NcIXHmdIR4DEVVyAcqjW9/F/1
	 v6QFnqksI435Ewsjc2VyGNyZGct+8HanlghdLAR0AcG+y4jjWIA3qVTgTkJHNQY0kX/QM
	 /pctTq365omGYhvO23ZbvaTzaaXcIUERb2++4WrdKV1BHdrB+BHl6PzAy5d1DiklPB7aU
	 tcBu+RqlzBWlEpO2PjpoWwQdXKxs90qYJofpuZvReKYifV3fSYH1NQqThy2QbPpSUEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=NKf4nqRS;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DE606A31C
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 14:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 900DE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=NKf4nqRS
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D59C6803EC;
	Thu, 29 Oct 2026 14:28:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 0B5532002D;
	Thu, 29 Oct 2026 14:28:31 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:28:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org,
 Nathan Lynch <nathanl@linux.ibm.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1] seq_buf: Add seq_buf_create() to implement
 DECLARE_SEQ_BUF()
Message-ID: <20261029102830.77858afd@gandalf.local.home>
In-Reply-To: <auNRKk_IaN8kBPiS@devuan>
References: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
	<20261028211227.2b644f2e@fedora>
	<auMtYh5eJKLjrubA@devuan>
	<20261029094156.141f8c54@gandalf.local.home>
	<auNRKk_IaN8kBPiS@devuan>
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
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 0B5532002D
X-Stat-Signature: 9z77ax7oihhf4dg5c9h738f6ptdp7g4y
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19VleNdqm3iKrEdprshLJpguh7Xj7sRJTQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=5VhPC5qeUgmGYgtyWWv5WYGcjr0/h9lMvKlu7ZUl58Q=; b=NKf4nqRSEk8w61IBNhiozT31zgA0WZkC2viKKHQIzNsW1XzHmRf8qBQkd0A1ILVaWBuzzuK8hMMT1RCd1gIbz6+XoHXyNWENjzIP1VQ3NXHwOcx+nActFNGLO4XQHvvlJvLtX2Tc//A7IfRyRiXnR5BERowwcGZ1fDp2t1qhINU=
X-HE-Tag: 1793284111-291438
X-HE-Meta: U2FsdGVkX1+wHTtKDr0GaClSEvloW2K1heRqokoesEU9ByNw0DZ1YerQVD8mh/20qYK6uctBXOn74bJiWm4CBxOuqjx6EyxmjlCsUJd7yf+pR5aD+IS/TKoOqjZl42QFOu+5KsKQsNcAW3KMpj7AwOSzJhlO/3asu3BdHC3QK9K0V6yN2qznvWHV5JnQMgno9SrKsrnqf8l5JUED3IRiQ6A3Op7NVgyx1lk350cWfXICOU8G18hKLMbfEzaNpAcFt3YWFHhYAuX86/TQ5qdNtc90k29w9TTXZ+glM6FAVLpHyIgs4UttTrqmHwJY1Shr5zOb8KpzzYBr3mkMaJbhnIZxKZEE+kMupb0nEy0ACgdkDvcWcl7PvQ==

On Thu, 29 Oct 2026 15:15:29 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> > Honestly, you haven't convinced me that the pointer logic is any better. It
> > looks to me that it may be just be moving the complexity elsewhere.  
> 
> The complexity doesn't move elsewhere, IMO.  It has an issue with file-
> scope initialization, indeed, because derived pointers cannot be
> constant expressions, and thus this precise problem, but other than
> that, there's no off-by-one-prone edges in that design.

If you have to change the current API to satisfy the constraints of a new
implementation, that is moving the complexity.

> 
> However, I understand the fear, so I'll try to prove the simplicity
> before asking you to trust me about it.  (I guess by doing a full
> conversion, and showing that the diff reduces code without showing
> corner cases like the bug we're discussing at the moment in the other
> thread.)
> 
> > Yes, using indexes can be error prone, but if you keep all that abstracted
> > out to make sure you can validate that it works, it should be fine. Nothing
> > that uses seq_buf should care about the internals.  
> 
> Actually, there are a few places where those internals somewhat already
> escape the API.  For example:
> 
> 	avail = seq_buf_get_buf(s, &buf);
> 	seq_buf_init(&ns, buf, avail);

How is this exposing the internals? It's an API and it only modifies what
the user has control of (the buffer supplied in the first place).

> 
> could be rewritten to use a single function (we can already do that):
> 
> 	seq_buf_get_tail(&ns, s);
> 
> This way, we don't need to have a temporary 'char *buf' that we don't
> really need in the caller, and we also avoid inspecting the available
> size.

What happens if there's no size left?

> 
> This could be done already with this:
> 
> 	diff --git i/include/linux/seq_buf.h w/include/linux/seq_buf.h
> 	index f006f2654e4c..f7ee062374bf 100644
> 	--- i/include/linux/seq_buf.h
> 	+++ w/include/linux/seq_buf.h
> 	@@ -58,6 +58,16 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
> 		seq_buf_clear(s);
> 	 }
> 	 
> 	+static inline void
> 	+seq_buf_get_tail(struct seq_buf *tail, const struct seq_buf *s)
> 	+{
> 	+       char *p;
> 	+       size_t size;
> 	+
> 	+       size = seq_buf_get_buf(s, &p);
> 	+       seq_buf_init(tail, p, size);
> 	+}
> 	+
> 	 /*
> 	  * seq_buf have a buffer that might overflow. When this happens
> 	  * len is set to be greater than size.
> 
> > Using indexes should not
> > be a point of failure as it's not extended outside the scope of the
> > internals of seq_buf.  
> 
> Except that many places do look at the size by looking at the return
> value of things like seq_buf_get_buf().

That's not the internals. And your pointer algorithm had better supply the
same API. The amount of buffer left has nothing to do with the
implementation of seq_buf.

> 
> > That is, once you prove the internals of seq_buf is correct, then you are done.  
> 
> And also except that you still need to prove the internals of seq_buf,
> which aren't exactly trivial.  With pointers, those internals become
> simpler.
> 
> I have a draft for moving to pointers, and it cleans the implementation
> quite a lot:
> 
> 	 include/linux/seq_buf.h |  86 +++++++++++----------------
> 	 lib/seq_buf.c           | 101 ++++++++++----------------------
> 	 2 files changed, 66 insertions(+), 121 deletions(-)
> 
> (It's far from ready.)

Don't bother. I don't think you understand the usage of seq_buf. I also
already don't like the changes and I don't see why they are even necessary.

-- Steve

