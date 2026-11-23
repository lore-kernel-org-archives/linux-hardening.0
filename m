Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.242.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425382;
	b=CJ5Ink/T4TX2Bn5wVYkEM/5MCn8VKtupQEYBGupJfIO5fblf4QMxXIzHgGK9uYa6Q9GU
	 S4YKHTfOVIn/5Kj8GJ/t5Ubi3DoQPxHQ2u0l1coEAFmYjxUQoqh2IBTb2jq7sduoED8ej
	 bsrIqpg+ADW8oNgkUdaeOggiUJ/fLBYkH6ZnPPaKN+bipxlO5tMahwHa4N31pSAoZtfkW
	 prGwqD5zlraE0314FccM6vNAwbE3BaOV1UWPw+jsd+tY+YgVlfSCFqmYrlMrTO8QeeKmM
	 eMsT7XwgCSzlu8n2OuHl3lgtIVMchdai47EK1a5yeWZsPLl6Oaqg1gj/rXDGBBkypAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425382;
	h=DMARC-Filter:Received:X-Spam-Checker-Version:X-Spam-Level:
	 X-Spam-Status:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mqD6jU+t4/7BDqwKcYC5doGDsa7FtGatu2yPza1Zim4=;
	b=nHbQpxhCvHrDj5y4UUwfpaqvOndJAi7Gjuq4zauk9Huhjn/2UFuKxTNBW/KbygIJ5X2L
	 7CoK1Vk2zsQiIoqA38wh8UbisKQn+2kCyjSP27XdnamKTTL/LKtfB6+8NBSph3btMHFLt
	 Dx4Zj8cmDOgmfhyLUd6635nK0L/VvJRcXxEP/xZLWD644d9Ejzo/Q6/DquBSBFP3lIL3k
	 LwaJkWULhmcWy84utM573K+WaHH357QGwT+qYweIwcgj9pRYBFbNwv0xa7SBaHYSgAsHv
	 SP7e79WB7KrPmcdxbW3F1RPVF6uuic6Pd7CBRSFt1bE5ixLNlRpl4EI5MlXRfUDETIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=davidgow.net;
	spf=pass smtp.mailfrom=davidgow.net;
	arc=none smtp.remote-ip=203.29.242.92
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1D606A31A;
	Mon, 23 Nov 2026 09:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D1D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 9566A200DEB; Mon, 23 Nov 2026 17:16:19 +0800 (AWST)
X-Spam-Level: 
Received: from shelley.lan (unknown [IPv6:2001:8003:8802:7000::41b])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 1CC19200DE2;
	Mon, 23 Nov 2026 17:16:17 +0800 (AWST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Documentation: kunit: Fix
 KUNIT_DEFINE_ACTION_WRAPPER() argument order
From: David Gow <david@davidgow.net>
To: Kees Cook <kees@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260921000021.i.218-kees@kernel.org>
References: <20260921000021.i.218-kees@kernel.org>
Date: Mon, 23 Nov 2026 17:16:04 +0800
Message-Id: <179542536414.535454.3568090867594251024.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=387; i=david@davidgow.net;
 h=from:subject:message-id; bh=ve5F3PWRwJ1+mdHnTtW68cuiRYfMdw9eOxO8XfQDUqQ=;
 b=owEBiQJ2/ZANAwAIAcYipzoZDNtCAcsmYgBrBARg9EKSA+oTpiu4IrtbCGrX90D+/qU3AMzfX
 jKXag5cyRCJAk8EAAEIADkWIQSmmTCaqhqZOsxDGC7GIqc6GQzbQgUCawQEYBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQxiKnOhkM20LC6BAAsYKNuGtzgfJvmAi62InYdtil8mc5I5H
 mTVwj4DsKJjZnNDJe1jkyUZj3RHNVlCyTWfOTOQmK5Hot9Zow3+t0znTt6WBENgzYyHGeUpdwW/
 OCGTrftFkSmYfXGufUG7OFBwrD6CCpDe95AFTZBtN09rv7GJnCtVZlNN1Cy+ppCiZLsbVJJo6qf
 TgRnQ8NL1n3h63TQda7mBaIGOX50iFo5Zl66le3wf7l/RrsahlHs0rJVEqWUuTa/KyPCrkWAtHn
 fGPPgN5PieiVklW35EOW7ID/3M00U45p0YS5Kz6rgyu7lXgjd8vXXJf7iba4j0WJTtkHYXEkz3G
 hwgg1iLMhar0IukLRWBFqXdg/zpWFw6FiUPrlc3BtULuB8NMhIxyhUhtPBtDbW4ODK9HB9KmAKJ
 KE3eN9YhYRownKuxFtGRuUUqhGO1L2HWKVbBWRZ/4hTNg5ONelEh39i2omMZ6WTfbGTynb0YSPJ
 tQ2W9gbNyETb3HbitTu7QECFpIRG7/qRVbF0TQ8qtrQek5MjZHoZhxxURj0B0MhTrpu0rTIn6+4
 5Hbeu2OTqlLkUcqTTU9l9FgTw1+oQnm0a4h5U81QdC5lGy9nZgu68AZXmU1qNTK0pQw2Zk1x1hw
 DIGyAuIyMHLnZNyS1ImGY14Fcdauz27ArfydFcPaLedg5xRMEC1k=
X-Developer-Key: i=david@davidgow.net; a=openpgp;
 fpr=3B0A53B1D9DF6AAC59C230322A821C5AD66AB03F

On Sun, 20 Sep 2026 17:00:25 -0700, Kees Cook <kees@kernel.org> wrote:
> The macro is
> 
>   #define KUNIT_DEFINE_ACTION_WRAPPER(wrapper, orig, arg_type) ...
> 
> so it defines "wrapper" which calls orig(arg_type). The example names
> them the other way round. Swap the two order.
> 
> [...]

Reviewed-by: David Gow <david@davidgow.net>

-- 
David Gow <david@davidgow.net>
