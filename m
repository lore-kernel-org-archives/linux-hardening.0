Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8977E3F54C2;
	Tue, 17 Mar 2026 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767572; cv=none; b=DhT+gtOekui/xYpTfArvb2yNUB598WkNrQ+meLdZhH/warWd8c45KtjlO40dyJMCScaB8X7hX+gVlogTd4kN3J497QT23nS9Xdv8/8XgFM1cQ61hqesDFVpkc4fRC0cca6w6ND4J3V4cklLC1tDGVlpPbYA+ES+YoNkhJvEfxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767572; c=relaxed/simple;
	bh=MkUqlGq+8WbdsyEkcmuk5r8HhcT2kicxmH1EFnsxj3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OfnUWxM7GR6APIdHT/VZujgJFTUM9KHUXuj73PRWNd1fjGLlnvKGl+L7pybztpUhPjpaipwFmebVzjqGVwenwbWseXQkTDpDpOcjsoPdiWnuTD9iaVNPA7fC8wYUNeQvGJNNx2/k+6iZx8R0SOPpicUMqNjxqrG66fbDyJpvQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=iclPxuaq; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="iclPxuaq"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CA07A40C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773767570; bh=YGW9AtIGtQaMlzk+gREVwoY+tud5xTkK4Urxl3cynwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iclPxuaq14pC/gS+AVEQH8T7X8DbPEjN4teBZ21H+Bxk8XCPGPvUNVQXRKqwUqhDP
	 h0mmdmWul+gxmAbFoDrf5OtTmu0892zxcWzF0GJnMxppAdaZfxfQypGJy8nqZQ6opb
	 +ix396oBQJ8guw033InBwYWjtEqLlNwPWoMkgKuo7O6OJvtVzGF6hWdT1YGnIbbgAq
	 GdDc7isDDlpiz2zjJWk/K0d2YcoNIAWdkjc05wwqaHTcjo+qj5DhJck8+4dliMrnWX
	 jI33k438MlKAvu8kJVMDPRX6DTJ70efpyLmyLtTZVyXdg/qlC2ry+8wHmhmCLcAhv5
	 LARxbOkHNCAhg==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CA07A40C7C;
	Tue, 17 Mar 2026 17:12:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Kees Cook
 <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Vincent Mailhol
 <mailhol@kernel.org>
Subject: Re: [PATCH v2 00/28] kernel-doc: use a C lexical tokenizer for
 transforms
In-Reply-To: <cover.1773326442.git.mchehab+huawei@kernel.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Mar 2026 11:12:50 -0600
Message-ID: <87tsue9y7h.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Sorry for respamming this one too quick. It ends that v1 had some
> bugs causing it to fail on several cases. I opted to add extra
> patches in the end. This way, it better integrates with kdoc_re.
> As part of it, now c_lex will output file name when reporting
> errors. With that regards, only more serious errors will raise
> an exception. They are meant to indicate problems at kernel-doc
> itself. Parsing errors are now using the same warning approach
> as kdoc_parser.
>
> I also added a filter at Ctokenizer __str__() logic for the
> string convertion to drop some weirdness whitespaces and uneeded
> ";" characters at the output.
>
> Finally, v2 address the undefined behavior about private: comment
> propagation.
>
> This patch series change how kdoc parser handles macro replacements.

So I have at least glanced at the whole series now; other than the few
things I pointed out, I don't find a whole lot to complain about.  I do
worry about adding another 2000 lines to kernel-doc, even if more than
half of them are tests.  But hopefully it leads to a better and more
maintainable system.

We're starting to get late enough in the cycle that I'm a bit leery of
applying this work for 7.1.  What was your thinking on timing?

Thanks,

jon
