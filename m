Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A039175A81
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463147; cv=none; b=cDA6bZsn15JHIZ1Lguuuy+dpgBf8Fbqwgqu+EooI0bCZTAD7s/oUR6Cj0SPBf+C7EmtHdL+Q4onE8eOuL5a9aBW/fh7cjkYlnRLJ/rieI1z5fu8uC4Dzj2Cdq/ZCIe0hwaEKg6+QmhhKStj35v9tahxBEkMiAhPzJjrkg8LVlaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463147; c=relaxed/simple;
	bh=K5g49topDl16HQABNaTMhXBq17mKUNyhauvI0z8A0qs=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=hhWTPyWX+TBTaVaN5kW/v4I8mXri779mz3x+Bzi/CAPS+ugc//dIItkQVyIWPKYBJLyRQOvteAHADowX/iGMGLpmM4IfPprnvf/ZR0wf9fDeSN2WLaw1d4M7fF9EwvBMeJAkTiV598dtGz0qVO2SZ51BmUndn5lEonvvtTGJqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RCMTWi+1; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RCMTWi+1"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g5FqT43hZz9tXW;
	Wed, 29 Apr 2026 13:45:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777463141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xaL8VcaU8H1R9SMtLtMJ1N8wtrCf/A8hHORhOEO76GQ=;
	b=RCMTWi+1S7Adm4i5Qd9KNVCPACBoZvHlEJCDJfHyVsSJmpMTyhWEVVNU5/v8bDL8+cciNu
	AZ8L2334kbHO88xg8tXu9LDW1kolYaqU3EzSwUQLaChdVtrROYuS39mOuiqSWs4piFB3dD
	17UqF5Nyiu9lGe0taTR3ZfZur8pCqfrLKLFwrTTYL3tD3xop1Wg7O2PgIBR9wtpOg0gRYp
	n6C/gC/wZQzI7Ck8S4nQBH/bRohLMgBLKmdfSXGHvdQUX5GhLl/TLN6hLQ+I2dLP1WI+ix
	sJX2BsPkg8NM2nYcHRsmIAdkdii75o4zBjh9QwMuDGyEzWkjJ2zPduAI+WTg/Q==
Message-ID: <2708666d-68f8-4cd3-9b25-f14ceeba3a1f@mailbox.org>
Date: Wed, 29 Apr 2026 13:45:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: linux-hardening@vger.kernel.org
Content-Language: en-US, de-DE
From: Erhard Furtner <erhard_f@mailbox.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: iov_kunit_copy_to_kvec: ASSERTION FAILED at
 lib/tests/kunit_iov_iter.c:63, Expected got == npages, but, got == 1 (0x1),
 npages == 256 (0x100) (v7.0.2, ppc)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ur1j3q3gm9worq7tf8p415mp9i7fsqhg
X-MBO-RS-ID: 0d80a3b4a733c79c910

Greetings!

Getting this on my G4 DP on kernel v7.0.2 and v7.1-rc1 via 'modprobe -v 
kunit_iov_iter':

[...]
KTAP version 1
  1..1
      KTAP version 1
      # Subtest: iov_iter
      # module: kunit_iov_iter
      1..12
      # iov_kunit_copy_to_kvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 1 iov_kunit_copy_to_kvec
      # iov_kunit_copy_from_kvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 2 iov_kunit_copy_from_kvec
      # iov_kunit_copy_to_bvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 3 iov_kunit_copy_to_bvec
      # iov_kunit_copy_from_bvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 4 iov_kunit_copy_from_bvec
      # iov_kunit_copy_to_folioq: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 5 iov_kunit_copy_to_folioq
      # iov_kunit_copy_from_folioq: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 6 iov_kunit_copy_from_folioq
      # iov_kunit_copy_to_xarray: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 7 iov_kunit_copy_to_xarray
      # iov_kunit_copy_from_xarray: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 8 iov_kunit_copy_from_xarray
      # iov_kunit_extract_pages_kvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 9 iov_kunit_extract_pages_kvec
      # iov_kunit_extract_pages_bvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 10 iov_kunit_extract_pages_bvec
      # iov_kunit_extract_pages_folioq: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 11 iov_kunit_extract_pages_folioq
      # iov_kunit_extract_pages_xarray: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 12 iov_kunit_extract_pages_xarray
  # iov_iter: pass:0 fail:12 skip:0 total:12
  # Totals: pass:0 fail:12 skip:0 total:12
  not ok 1 iov_iter


Suppose this may be a ppc/BE specific test failure as I don't get it on 
my Thinkpad T60 (x86).

Full dmesg and kernel .config available on request.

Greetings,
Erhard
