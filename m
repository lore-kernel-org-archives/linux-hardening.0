Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9247127E;
	Sun, 20 Sep 2026 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924144; cv=none; b=BKrghZT2f4+5Ks9SA5EJUJ9DHxOugixnD0M0Gms/b9D5oU5DevhW7cnzSgVL6VihbA4GAbOostMkwP5OWRGDoDMIeazfJZE+puIQklQctZza6flvFv1xm0wf7jLZw7B/mlU1knTHVZQtkGq9NMB0QSKQi8yKoL0xfwwdGr/JBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924144; c=relaxed/simple;
	bh=PVwzTAfDbpdqV36ICbXuiy9gs987Rys+zxMKo9i7PWE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JpmSZ0HoblyeGtZg4M6on6yehCWEEd4sVAotykeSSBXPqqkF4n/OBBZbWgv2nZP6t8KDt5Y3o8nA3qoGqSOc9Ni7NATSj6DDORXKv9TLHrLHuRRDOZr+DVAIhoW1eREQHD6vw6/DYej6Hgqlxdu5H+Pt7St4ZRv0VeVkaMJZCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOkeKLEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOkeKLEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669D21F00898;
	Sun, 20 Sep 2026 17:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789924143;
	bh=IH2Hu+LoUs1U17Bi1CdBu9OUsMj+vs4g5/x81CSnGd4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FOkeKLEci1bvvlZtgUK95VNREAwG72jFH1aPhxtRJs1WAqqpFpV4PP1g1QRFXfNti
	 vzAh5fbdYG2IxVEWCoWSSHiKRfVjI8uXTUlr7snh5Y98VwhjJLSdKoba7P3wtJbpzb
	 Rzlb/KefIPMfcomXGetFMw5H+yonspHDMOKIGUdf5gJSfJ+CJ4V3RqRAmAiocPq+7n
	 qPZ7v7L0QKLSKPO4MU/FmtKZZkg/fDhe819xWCz7itfr/ECKMZU/NdoP7qACTh6xl9
	 4irvU2DkHMVbwWYAznrdYNuz+lLzjWgTZczbN9uiUJdcSEP62E0RbaDgE7zPWE2tdg
	 er7aOu4n3f7yQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Santosh Shilimkar <ssantosh@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260917211253.i.532-kees@kernel.org>
References: <20260917211253.i.532-kees@kernel.org>
Subject: Re: [PATCH] memory: emif: Remove const from min_tck allocation
 type
Message-Id: <178992414218.36544.17553172588859398493.b4-ty@b4>
Date: Sun, 20 Sep 2026 19:09:02 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 17 Sep 2026 14:12:54 -0700, Kees Cook wrote:
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The size was taken from "*pd->min_tck", so the converted allocation type
> would be "const struct lpddr2_min_tck *", as "pd->min_tck" points to
> const. The allocation is a writable copy assigned to a "void *" and then
> memcpy()ed into, so name the unqualified type directly, for a converted
> allocation type of "struct lpddr2_min_tck *". As there is no general way
> to remove const qualifiers, this keeps the allocation type matching how
> the memory is used. No change in allocation size results.
> 
> [...]

Applied, thanks!

[1/1] memory: emif: Remove const from min_tck allocation type
      https://git.kernel.org/krzk/linux-mem-ctrl/c/e3049c9edd4181e5ce4f83bbac4b611d921f45ff

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

