Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23B63A5433
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123466; cv=none; b=YSUrs6N4BspoYSE2hpS1Ilth8pB0wLQLFRb52mW7kZE3WKB7rUAcwqp/qSnVotRQoGmM2ya8SlmgchXEtCO2XPh0Q7XE1i/gUEQnD/AXbxiV/z3cY+zOALnHXg+plEtfOJmn9UnXpmEvPUKa0BVEWqFCppOtHE69weA3W0TWsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123466; c=relaxed/simple;
	bh=QnnTNtwjLBfbxy8zzPGWSQ8HI5pO4Y+zssCxz1/puYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0w8OvTFpAGVgqR6BgiYjdJUcb2WferEIDX7I52pcAAFH9TG8Va2kL/ys9R5QRQfmHieGpO3MbMKSzvr8WWp/1g4xM/ic/K7Xj69niA+O+qD3fSLvisq4U1ugyBwAQPWaFr1HmXDKSNIxCRUJoSehZ/tpNHD5mr+TCpMzSSDDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDf7a0B9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDf7a0B9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso25372135e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782123463; x=1782728263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdT78b4A5DNqBgEoFgT0uFGWS3MO+ivE5ufwX9sjclk=;
        b=YDf7a0B9OrtwSvrXmYdYHbf2u98oe0dOCxJJfv5L6jurZYoq5XR0TNUN9c3R4HJIgK
         UA4Jm42gg+lTrSPMOjbW2hE3iiWrMM5l+j+Y7gUl2fTfMtFqIlJJrTCJl3DaV1k3y6iU
         q9ttqSEDizjgxBTHOocxcm4/clyQy5db4Qxdxhddseyd8cguT8OQjw3UGfQhI9r+pGkX
         ktf9Cu+82gFjeyB/SGlFAOhVVsaQG4wnQ5QJeLMPzPprsD40t5exMKrijBXpT2R0db6m
         RhKk6LxazT7wOKDnpahsMFeWN3WbSLaaghVika5SuEvJKE+z1GImXDuRXR3QlTtlHhrO
         g32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782123463; x=1782728263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdT78b4A5DNqBgEoFgT0uFGWS3MO+ivE5ufwX9sjclk=;
        b=DVdqZGoCP+wxK/beq1Nv14Ca+M9y1rgPP2AKaC+sUOGH4tX0/0G7nVLnoS37Xcu0ra
         2KcOj3CkrVzpkDtQTCZpZsLGcvm4MADJ5rApnefJzj7TWebB+Q5jij+Hp3n0kfjhxAPA
         SYEVKJALlvicIe9MYLAvFcBN9Zyv2kZofHSATURlz5lDaeDfvwqNq6SWqyC1cC8/BJB6
         7+KkrBYoUNOguxaGCcsxcXLeQgCD93PPPbRKsjYN5qubuWQlaEoZhzXJnT+0cuPANl5j
         wx5ioNl+AfnQOrbm2dyCvOW5hm6flNp0ifu2c0r610N7z5f4aIiBcW6A28tAdbhpuh8H
         dpYw==
X-Forwarded-Encrypted: i=1; AFNElJ9slhm2c7otGMtdSZbXGWg1Q5Mo7kibM+M1DS9hhWwRriShqBjvI7NxDLdTCHrJ5sphMPCLDSRzG0LALrkL31o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUrV6RVput+oAZCWc/99b/b4F1TxLZAi0nO7ZeyCPBswHVes1
	wE96OX8S/frkyuebtmgzjmoJhX0ebZo7elLclqtUQ8TMzRQfXXzqzlA2
X-Gm-Gg: AfdE7cljqlv71bjkhO4YaRQfIuMcwTbFlV4UvJ2eWAXY2ewRZlCU20HvjfYVL3wJ2Lz
	EOZuCQ+ubnhUHEn2gXiVGQJjvu6FhWPYBs3jgW4uwfpF/QPX/ZMrgmn6SrZIyXPrIMYJPoU/d4q
	hvF7ziEpYxl1KbIdMed6DZAXKob9w6RhIlfDyW+J54IkLfJltMGGNHk4fejYSmlEoVI8ZdXag25
	vdWcjdVEOQSPoksPzAI9pV6a5kwLUjIq9KXTpn813cndCbjsTTRVcfS4+a8EhiKnnY6F4cGzNxs
	TIe6fWNcOYMkBlxbdGgHoqikzV2SuzOyWzL7UkdieCMPfeLKgrm67TmAsEyNQECw5G0JDpdrCqz
	e1W4wm2h0xJSfpORL3JKtTEG6ChpXjy7xzok6RsLcN/O8xlGlBsIJlnj144H+BlaJLxGFDXc8Cj
	5qFYvTYGgtal+3bAGx8VksLtTQjGA7MP5NT5H+lFCqhehpe7AeMg==
X-Received: by 2002:a05:600c:8011:b0:492:2ffd:8f8 with SMTP id 5b1f17b1804b1-49240e19b44mr236492405e9.15.1782123462838;
        Mon, 22 Jun 2026 03:17:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm24991696f8f.23.2026.06.22.03.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 03:17:42 -0700 (PDT)
Date: Mon, 22 Jun 2026 11:17:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH next] fs: Replace strcpy(s, "../") with memcpy(s, "../",
 4)
Message-ID: <20260622111740.63820fc2@pumpkin>
In-Reply-To: <87se6fdkb2.fsf@t14s.mail-host-address-is-not-set>
References: <CnPdNyUGjsYpAP8JdysfUf4wkBkm2a923cQ1hE4-mg0sUnJIm4Uj-cAkdVHswEsuZ3d6vhmX5eil2zLmrkfl3A==@protonmail.internalid>
	<20260606202633.5018-5-david.laight.linux@gmail.com>
	<874iiyg5kj.fsf@t14s.mail-host-address-is-not-set>
	<20260619143438.495c1780@pumpkin>
	<87se6fdkb2.fsf@t14s.mail-host-address-is-not-set>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 10:57:21 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> David Laight <david.laight.linux@gmail.com> writes:
...
> > I just looked at the code again, the final '- 1' on the 'size = ...'
> > line looks very odd.  
> 
> It's to leave space for a null char at the end. `fill_item_path` writes
> the path from the last segment to the first.

But wouldn't that be a '+ 1' ?
It might be alright because (IIRC) the length is initialised to one
in the helper function.

> 
> > I wonder if it would be simpler to merge all three functions into
> > something with a single loop that builds the name/name part backwards
> > from the end of the buffer while adding "../" on the front and then
> > calling memmove() to put the two together.  
> 
> The current implementation is difficult to read for sure. It would be
> nice if we can make it more simple to parse.

I dislike code that does two passes, one to work out the size and the
second to do the work. All too easy for them to get out of sync.

One of the pathname functions (but I don't know if this code is used for it)
lets the string start part way down the supplied buffer.
If it is that case then it could be a lot simpler.

It also wouldn't do any hard to try embedding the 'char name[PATH_MAX]'
in a structure - so the size is passed implicitly and the compiler can
check and humans know what they can do.

	David



> 
> Best regards,
> Andreas Hindborg
> 

