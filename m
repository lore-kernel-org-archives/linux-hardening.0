Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236358;
	b=dtnBRBtgJbzBWSbrNdv8WXRxQ65MQB2+9oG0CSZf5Ag7Y+Z2kqs7n12YF9J8bVSSXCuw
	 jODSHnpp3l0H9BETBxiK4qs4AQyzJIGHBnL4qpolh25d+mYSZC9BzCg9SS3P2VPejTdjo
	 vZkOwrpm0vBUdWBVt5c/XjQ8r9FAO9CB6XFXtFAa2ODNsUhKoe1UYQlsxPs1virvI0fyz
	 BRbGXHMU9bN8DxTXEcPS3dpRG+9O00usbV6gy7KZ63GEiXeSdPHzq1uentfdZyV3/tmea
	 1wIQ3TnVp/qbKhIXVJelFrkPSKOPhwVV1CuSZoCFdToTb2ytpvWgKw7WJ9dZd7AR0bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236358;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=wAAmwQVjLkMbTkbDLRO+49h6VeNsbGqrurK45kFujis=;
	b=rtlwtrNiUMLUkiQJWG135a4G4Cks08BFKlFv92zk1QZC5/W4WbdmhhTiecnEylU+j8B1
	 vIg9o3TWSy/TvATCwJjXzZoHFQmeR9vIc9H68Pm7ZbecMxvfF9kSkr+u5/vxKRfZY3qUS
	 ILLF1xhRejfLlDGuyg61iyx+wFzPAD9dxSRShNvw5gDLSn4deWrbBk+ZA4QBnyAhaa8mv
	 zOXbjbRO6iEhzXk7pGMKzFJpJmyhBF7VyuXfSbzK3/e76VmnRAmwW+y4JplO4YDkRa+YS
	 v86F1jWmF69hbyotI+VhGM5o+0IQ1mIvfQZw+MvFJ2B8AzwCjMyMTnvenqQI4HW9M0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=YQbB3Mij;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858F606A320
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 01:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C858F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=YQbB3Mij
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A0708A7AB5;
	Thu, 29 Oct 2026 01:12:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id DFDE820025;
	Thu, 29 Oct 2026 01:12:28 +0000 (UTC)
Date: Wed, 28 Oct 2026 21:12:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>,
 Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1] seq_buf: Add seq_buf_create() to implement
 DECLARE_SEQ_BUF()
Message-ID: <20261028211227.2b644f2e@fedora>
In-Reply-To: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
References: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
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
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DFDE820025
X-Stat-Signature: ynrypuaft65fb7ep8dm5xp6umgcmmf8w
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+N7QRY2w7ZcJgDVdnOej301D0/7nGSsMY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=wAAmwQVjLkMbTkbDLRO+49h6VeNsbGqrurK45kFujis=; b=YQbB3Mijp909d8rtDLSDE6M0/b0lxTUYfVQrZiTIUyLm9rCFojK3+jusmM+7KMpF4ByyV90GXUu0Whf9TGcKn6GLt5D4LzkquaZlYMdFGVFFQrDz3/EoAedXRZHOdhsu2/ZyUU3KXphGCJfmf5I4y7nZcBcJAs2xtAf28+PrR8k=
X-HE-Tag: 1793236348-841175
X-HE-Meta: U2FsdGVkX19HxSQJeWu1VKpAoUrr9Lx1c7Ztz7WEp2FbdeL+j7m+1qa0urP6LiSev/E/j6J+I/U/x9m1cXi5Z86Lb16xxNuBLm6WCIG4k+4JyKC7pgW0qANNy/MfUY0NLYlUIyeWv3kHz3dW+qmcIWoUo0d1Rdbvj6s2ywqgzo8ifE9axgKZOs6y3aKYxwh8R+Nb38H6WcGGeZe4UK191utq7j+W6FaaPz0oK/qXZrU7rkKQ/ZBPgwmERtBVdQHkMBXYYEAsBTKRgKm45VOlkbniQek6W5G0Dby7VT2hF2w4EgpqO+S7CODyrtnmdySP2SWqKf4qmbo7z8Fvb9xX9f9oMafQBhToJx2kWOyUrE+Gl9f4aaqeJjkq4Jm47arWaJI5PS/MWFV1FYf3/OWvG4G5K3udNtTuM5b/lNPPX9NFJBPXJvIgY9lGuLsksRQugK1nT88tTlc=

On Thu, 29 Oct 2026 00:19:24 +0100
Alejandro Colomar <alx@kernel.org> wrote:

> This implements DECLARE_SEQ_BUF() in a way that is independent of the
> members of the structure.
> 
> This will allow transitioning to a different implementation of seq_buf
> which uses pointers instead of sizes, on which I plan to work soon.
> 
> The compiler should be able to optimize this out and produce the same
> code as before.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
> 
> Hi Steve, Kees,
> 
> This is a patch that I could split from the rewrite using pointers, so
> we can apply it earlier to reduce the later diff.
> 
> I've built a kernel with 'allmodconfig' to check that it's okay.
> 
> The reason I need this patch is that we can't calculate the end pointer
> of the compound literal without passing it to a function.  If you want
> me to hold this patch and send it together with the rest of the rewrite,
> I can also do that, but I thought this might be useful by itself.
> 
> 
> Have a lovely night!
> Alex
> 
> 
>  include/linux/seq_buf.h | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index 9f2839e73f8a..facc5643c049 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -25,10 +25,7 @@ struct seq_buf {
>  };
>  
>  #define DECLARE_SEQ_BUF(NAME, SIZE)			\
> -	struct seq_buf NAME = {				\
> -		.buffer = (char[SIZE]) { 0 },		\
> -		.size = SIZE,				\
> -	}
> +	struct seq_buf NAME = seq_buf_create((char[SIZE]){0}, SIZE)

It can't use the DECLARE_* name as that is by default something that
can be used outside of a function:

  DECLARE_SEQ_BUF(foo, 1024);

Needs to work. Just because nothing does that now, doesn't mean it will
not happen in the future. From my understanding, all DECLARE_* macros
for other types work this way.

-- Steve


>  
>  static inline void seq_buf_clear(struct seq_buf *s)
>  {
> @@ -45,6 +42,15 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
>  	seq_buf_clear(s);
>  }
>  
> +static inline struct seq_buf
> +seq_buf_create(char *buf, unsigned int size)
> +{
> +	struct seq_buf  s;
> +
> +	seq_buf_init(&s, buf, size);
> +	return s;
> +}
> +
>  /*
>   * seq_buf have a buffer that might overflow. When this happens
>   * len is set to be greater than size.
> 
> Range-diff against v0:
> -:  ------------ > 1:  9bda534b33f0 seq_buf: Add seq_buf_create() to implement DECLARE_SEQ_BUF()

