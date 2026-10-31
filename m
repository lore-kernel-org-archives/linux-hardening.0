Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420011;
	b=zmugZ1x5HZFIum+ahIqj6xMpIkNRzsrJ/Qa7f05BIn2HBA0TwRX1SepDWSa0R0HDEgVM
	 XvVyvPDqp9BIKqRmpoj137RW2fZeONjC12S/4DasWh40GW5nEjuoYgzTXFrsIGmfo9H4J
	 xLgivU3oVkD9s2q9nduVqnQTH8tGhUxw6UPBICSswivZQ07ELzsjKEjoO7mUc3Tie5rxz
	 A8rmMxVxxUtwQta33PN3DPyBLBhrzRbqP9kcybfY7r0qJGL9ZhG/F1u3jKKY+fj4z31Bx
	 h3AgNtWe2fOp+uf0PVy3b+VM/g7hvlnFLHw+QOb/CvPpcmvCMz0T7SZ9zgXNr1K+gtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420011;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3hdblefE6S5tAiJMj8KJmoICUKdholikSnOmEf5tzMU=;
	b=X0v/rwl/LIsLamJ1pshdNn66YI2oDkeGBminXiC5f3+GHN4Hb311Aui8qR2h+OqgvA8l
	 UfUUZrf2brW9QzR1WEkIfw8hXSKGbRlHTTNSz5vswVxwiClEa0H19++P/5eGLZwUjic3N
	 rpN2gH6QZzWRQHtMbPylwGwXgjje2Vg+EXW135//kJa7CArEt2WAwlwvAWmA92ULhqNr0
	 fe0jQtEmeXKTqGn0OlKZHe5CnPJmrHeNpuZ4j8xtEJXzFqOsWgotAXdRLzuOawlf4zQ2p
	 B12tFhWDvRDv0d6miZX8wFF12jW9kaaeWOVHk336WrRhdPK42Ik1i9UefGk20mNhGlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4EQdXBN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F569606A31A;
	Sat, 31 Oct 2026 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4EQdXBN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F601F000C1;
	Sat, 31 Oct 2026 04:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793420011;
	bh=3hdblefE6S5tAiJMj8KJmoICUKdholikSnOmEf5tzMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R4EQdXBNX8QLXGc0X8TmBH9Fb9wWbqf+Oyh7f7jwj4AQpxv0TaRTM+7oBwtj9pXcT
	 kufcOzg4jPz6GRNP+iX6tFOWBfsU1mAYaGgqHYG2KRsiM14/+4ZLjO7CJBikdSMBpJ
	 wVkiA3Y5wG7dEInpGmZFZ2JLXRYrEJFIGjxAMD5eqBw8yBcxEEyJxPAfr+XSZE/98X
	 0AwNwjGi479VRMBjZkIVFsZ8kiCCML/MQmWVQtHlS9ylY4ZS1f21kzS1cLumk073Lw
	 Ve0mbW/MPWGakjeHzDS4YCtvvKb4rP50KyXWyYkP0gtn7AIbRYA/mJFlm4a2Soau1B
	 EBx8vWbmq8Zmg==
Date: Fri, 30 Oct 2026 21:13:30 -0700
From: Kees Cook <kees@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 1/6] mm/slab: Enable SLAB_FREELIST_HARDENED by default
Message-ID: <202610302112.453CE16119@keescook>
References: <cover.1793253633.git.chris@chrisdown.name>
 <2ba9dc862607d70050bbc86fce0091de2e23c023.1793253633.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ba9dc862607d70050bbc86fce0091de2e23c023.1793253633.git.chris@chrisdown.name>

On Thu, Oct 29, 2026 at 02:07:22PM +0800, Chris Down wrote:
> SLAB_FREELIST_HARDENED obfuscates the free pointers stored in free
> objects, and catches naive double frees and frees to the wrong cache.
> Most distros already enable it, and with sheaves its cost is small,
> since the per-cpu fast paths don't touch freelists. Measurements also
> show this quite clearly [1][2].
> 
> So let's just enable it by default. SLAB_BUCKETS defaults to
> SLAB_FREELIST_HARDENED, so it's now enabled by default too.
> 
> Link: https://lore.kernel.org/all/auITixAJMfLtfa7i@chrisdown.name/ [1]
> Link: https://lore.kernel.org/all/179312451613.474906.1475329637924619088@kernel.org/ [2]
> Suggested-by: Vlastimil Babka <vbabka@kernel.org>
> Signed-off-by: Chris Down <chris@chrisdown.name>

Like I've always wanted it. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
