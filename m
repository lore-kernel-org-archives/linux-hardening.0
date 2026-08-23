Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DD33998;
	Sun, 23 Aug 2026 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787492915; cv=none; b=BliWrcAhtVGXqD848wcF92ngyJ8cPq8DIcAU36FWXvrXqjP45SvwvKvPefE+6SuCIHO/p/C1Ja6DH7g618nvVuFsuw30hoH45hTqK8jadMM+I9GlxhEJ7rbP6RhLSBrDEACmI+Ku/zDUKJIo4ndg2w4jXU0Hednzw6D+kFAxS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787492915; c=relaxed/simple;
	bh=/GNNyqBVM0zqmwlkahrpnAQ6K3slJ3fp8MTwo4J56DI=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=XezkFrutNzAlU/6OFJl6+1aQdr1idfS2u48+EiceRHSKjjoW+iOEvfvnlITuX5XQ44302FABPjdrQQBgQDdROFy8tTLz3Drt9vNiGaThWWfJ4Cvyxpv7yjizEzrYG6QmEm8RUzYw3DKgPoOuyyBI4zzN9T8eEt3gWGs7GQqAvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=VcMKypRN; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="VcMKypRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787492903;
	bh=EKgrrdOvC+GKP889SAXaxlzU7raewT2XaPt1L/hg8MQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=VcMKypRNn7qj12EcjHqTnNhE3bJjzlQSAN1DT8OCf59vKiNM51l+SSAsQny0+m6uv
	 5IXPJtMPEQGJXTzxgKOLuji/h9ejjmbUXwX1tiOa41KJZVo3zDLSZk1cDWf6eLHJ+b
	 tBg2FeWb2xeC5fOnFeQ7/3HWjRgCP1pepwcCtYHc=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hSb3W1yRsz10y5;
	Sun, 23 Aug 2026 13:48:23 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hSb3V5jfTz10tW;
	Sun, 23 Aug 2026 13:48:22 +0000 (UTC)
Date: Sun, 23 Aug 2026 14:48:22 +0100
From: Bradley Morgan <include@grrlz.net>
To: morbo@google.com
CC: aliceryhl@google.com, brauner@kernel.org,
 codemender-patching+linux@google.com, cyphar@cyphar.com,
 dianders@chromium.org, gary@garyguo.net, gustavoars@kernel.org, jack@suse.cz,
 kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux.amoon@gmail.com, nathan@kernel.org,
 nsc@kernel.org, ojeda@kernel.org, oleg@redhat.com, tglx@kernel.org,
 thomas.weissschuh@linutronix.de
Subject: Re: [PATCH 2/2] userns: Add KUnit test suite for uid_gid_map
In-Reply-To: <20260823125155.1136740-3-morbo@google.com>
Message-ID: <F22B12C6-D4C2-4A7D-8C81-B5FF6443DDF0@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Bill,

> +config USER_NAMESPACE_KUNIT_TEST
> + tristate "KUnit test for user namespace map insertion" if !KUNIT_ALL_TESTS
> + depends on USER_NS && KUNIT

The test is #include'd into user_namespace.c, which is builtin (USER_NS
is a bool), so =m here still compiles the suite into vmlinux. With
KUNIT=m that calls kunit symbols that live in a module, and the link
fails. Make it bool and depend on KUNIT=y, like EXEC_KUNIT_TEST:

 bool "KUnit test for user namespace map insertion" if !KUNIT_ALL_TESTS
 depends on USER_NS && KUNIT=y

> + /* Verify sorting is correct */
> + for (i = 0; i < map.nr_extents; i++) {
> +  KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> +  KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);
> + }

This doesn't verify any sorting. Every extent was inserted with count
5, so the loop passes even if sort_idmaps() did nothing. Either assert
that forward is ordered by .first and reverse by .lower_first, or drop
the sorting claim from the changelog.

> + /* Clean up allocations to avoid leaks */
> + kfree(map.forward);
> + kfree(map.reverse);

Nice.

No tag, add me into V2, please?

Thanks!
