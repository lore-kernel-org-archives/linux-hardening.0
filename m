Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8204322F9;
	Thu, 23 Jul 2026 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799494; cv=none; b=hcEfljW4c5rckQLqLFLuYpsFqbdkj58QF0SM1Leo91mSQ+UufWl0CXOs6pbvVo8OBlfnUaxtoDf+XO2Ym5rbigjlCRch+IeI5GRdsFnfeBiB5gAy+GHn6wMCo9RVBgBavRs0jILs1KHycviwX/QZaiIdrisjZ8YinFmGxoWQM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799494; c=relaxed/simple;
	bh=Yr/CnKrx8tpeaaaZ3rB31RdlrfJ+ZriYNqaUr4ghol8=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=AnQdnVG727exNdFeQy88wPQI2TAh4mNlGNwanfu1CRwELgClMRh5fG4kGQVArUChznRjtzMVwtOFcNOgJp8VRaJ5WfR9nvCqKnS4lgtbrJ5r1Y+ckh7iI5+cZKYLqQhurkKXOzYfylMNBK3cbGmzTsVuz3Z2KqymNlbTofA33uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4h5Qyq3JCZz57HS1;
	Thu, 23 Jul 2026 17:37:55 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl1.zte.com.cn with SMTP id 66N9bpJW087992;
	Thu, 23 Jul 2026 17:37:51 +0800 (+08)
	(envelope-from gao.rui@zte.com.cn)
Received: from mapi (szxl2zmapp06[null])
	by mapi (Zmail) with MAPI id mid12;
	Thu, 23 Jul 2026 17:37:53 +0800 (CST)
X-Zmail-TransId: 2b086a61e0f12bf-4ad4c
X-Mailer: Zmail v1.0
Message-ID: <20260723173753894Kxzf20CEYWY6st6LVYgGn@zte.com.cn>
Date: Thu, 23 Jul 2026 17:37:53 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <gao.rui@zte.com.cn>
To: <jiangfeng@kylinos.cn>
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kees@kernel.org>, <andy@kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIGt1bml0OiBzdHJpbmc6IGFkZCBzdHJubGVuIFNJWkVfTUFYIHRlc3QgY292ZXJhZ2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66N9bpJW087992
X-TLS: YES
X-ENVELOPE-SENDER: gao.rui@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 23 Jul 2026 17:37:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A61E0F3.000/4h5Qyq3JCZz57HS1

>> Extend string_test_strnlen to validate strnlen behavior with
>> SIZE_MAX input:
>> ...
>> +            /* Test Count overflow fallback */
>> +            KUNIT_EXPECT_EQ(test, strnlen(s, SSIZE_MAX), len);

On 2026/7/22 15:10, Feng Jiang wrote:
> A similar patch has already been submitted:
> https://lore.kernel.org/all/20260526085913.429049-1-min_halo@163.com/Thanks for the pointer.

I checked the patch, but it does not actually cover the **Count overflow** case.
so my patch adds an explicit case for `strnlen(s, SIZE_MAX)`.
--
Best regards,
Gao Rui
