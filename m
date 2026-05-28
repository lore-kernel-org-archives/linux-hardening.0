Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6A33F8C1
	for <linux-hardening@vger.kernel.org>; Thu, 28 May 2026 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952003; cv=none; b=UWnvzDRocqhOiMiyWBnEzhGxjs/lj4ZpkeJmRmtZ/wEMrcsSC1cTHvXcMqDZcxpRo4CgyjTMpJXyGham2xWmPAPWxJ6glhSTbtGIo1po/yU8ngQ5bVizSDUZFbYv7Aq8BwPny/jajanjt2OitMoEqK3ufhPasSvBdQZimFR3lIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952003; c=relaxed/simple;
	bh=Alp6pz18Ku5DV5YJ6h+f3xmg8R271lx67qyOfBSkLFk=;
	h=Cc:To:From:Subject:Message-Id:References:Content-Type:Date:
	 Mime-Version:In-Reply-To; b=AKidHmMENMVh/uGl1aoLaP3bgzsUVdriAnm2z9fmqpfWOH584p6UaR5ThnP7OWgUbNJ3B5aYKzbIwzYoqi2n5issEKHqQuQ9i8Zk6CKEY+I10D2QN47b20A0De956+HwhacBP8UTrGTsYphvfXm0kMsWbmvpDt+JD2K43xVvNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fCfhyOZJ; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fCfhyOZJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779951994; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=my2xvfOIM0CS3HYizu8JqBpZyrW0PkSKxr4c77D1g00=;
 b=fCfhyOZJmhPOLqzOWpDdiPGbbl0JGQuurLOziqmhfRKrt3ELQzZhRPuGnJpU5EIeTJL5OY
 XlyisbSFtnKO4Qw0T+wL5lcyLeJntfVWXMnOBzWL964v9li/PBxvMwpUG5va0hZEEJhWSi
 a3jqtjH5kxomcovZvmIqcEJndzJAYvGITcd9SjnsyNZbW95dn0ZoyDED3KPSnvg8xFOLzI
 xGs67MSSia9MXOFIn83ODGEauYxfG18XcDOgTqUUEqt2FjG9v78XNjKJlrux/Nei2nDdmH
 aPK868hz/vCxuQsHAj/KUooz3FMeiGzinszQ3JjrbnrUmoiF43kLQhPr4qZkAg==
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
X-Lms-Return-Path: <lba+26a17e978+296eb2+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v3 0/8] mm: speed up ZONE_DEVICE memmap initialization
Message-Id: <20260528070611.85255-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
References: <20260527134637.29621cc94aba22eb02f3a544@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 15:06:11 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260527134637.29621cc94aba22eb02f3a544@linux-foundation.org>

On Wed, 27 May 2026 13:46:37 -0700, akpm@linux-foundation.org wrote:

> AI review had a number of things to say:
> 	https://sashiko.dev/#/patchset/20260527033636.28231-1-lizhe.67@bytedance.com

Thanks for the review. All four points are valid.

  1. The head-page template setup should not run page initialization and
     refcount helpers on a stack-resident struct page.
  2. The compound-tail template path has the same issue and should avoid
     running compound-tail/refcount setup on a stack object.
  3. The x86 memcpy_streaming() eligibility check is too permissive, so some
     transfers that cannot stay entirely on the non-temporal path may still
     go through memcpy_flushcache().
  4. memcpy_flushcache_small() should reject unsupported sizes before issuing
     any store, otherwise fallback can observe partial writes.

I have prepared corresponding fixups on top of v3.

Thanks,
Zhe
