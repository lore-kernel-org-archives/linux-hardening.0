Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B292627F9;
	Tue, 27 Jan 2026 01:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477191; cv=none; b=e3kbXAkOIC6IYN0QplZQht4rdeaSLGe5eWZBPSXQqAZCojGGP9wE+mt20FJBo5uJ1uS2G2oG0xkmtudN3L5aLGOkbjdJdRSdgWWnA0BfRrHLRGzDaQZ+8jFA8USxuV8+d5ZAld/Qj6AzxFAun0HqnSo3Y+prQ6r+zRYRlpbODgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477191; c=relaxed/simple;
	bh=oFhrNKlazxy+i2GDEurxZZB6hrD/8JyA8CfHOPh4zzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DgaLgcMM+n/sxZjGbmakN6c0nT6/WGqxwHMZOzARZ1xEdsSk/ej9jO7frFeS062Tg+v/p/S2Ox/bl1ig6OoAHd2rgsnasmV89IvqAgC7UD++q4h/jiIyvsPK2R8ztVMLqskPuVgJnhy6vbKru6qQwlMeiJ8BdEE5PVZgavmasBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 30878696fb1f11f0b0f03b4cfa9209d1-20260127
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2684c0df-676d-4e03-a677-861975f869cf,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:2b077f54cad1216696474bc67f3f7b60,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 30878696fb1f11f0b0f03b4cfa9209d1-20260127
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1487477625; Tue, 27 Jan 2026 09:26:22 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	kees@kernel.org,
	andy@kernel.org,
	jiangfeng@kylinos.cn,
	ebiggers@kernel.org,
	martin.petersen@oracle.com,
	sohil.mehta@intel.com,
	charlie@rivosinc.com,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	linus.walleij@linaro.org,
	nathan@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 5/8] lib/string_kunit: extend benchmarks to strnlen() and chr searches
Date: Tue, 27 Jan 2026 09:25:55 +0800
Message-Id: <20260127012558.40025-6-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260127012558.40025-1-jiangfeng@kylinos.cn>
References: <20260127012558.40025-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the string benchmarking suite to include strnlen(), strchr(),
and strrchr().

For character search functions strchr() and strrchr(), the benchmark
targets the NUL character. This ensures the entire string is scanned,
providing a consistent measure of full-length processing efficiency
comparable to strlen().

Suggested-by: Andy Shevchenko <andy@kernel.org>
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
Acked-by: Andy Shevchenko <andy@kernel.org>
---
 lib/tests/string_kunit.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 3fcd55953bd7..c338d35d3ea3 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -858,6 +858,21 @@ static void string_bench_strlen(struct kunit *test)
 	STRING_BENCH_BUF(test, buf, len, strlen, buf);
 }
 
+static void string_bench_strnlen(struct kunit *test)
+{
+	STRING_BENCH_BUF(test, buf, len, strnlen, buf, len);
+}
+
+static void string_bench_strchr(struct kunit *test)
+{
+	STRING_BENCH_BUF(test, buf, len, strchr, buf, '\0');
+}
+
+static void string_bench_strrchr(struct kunit *test)
+{
+	STRING_BENCH_BUF(test, buf, len, strrchr, buf, '\0');
+}
+
 static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_memset16),
 	KUNIT_CASE(string_test_memset32),
@@ -884,6 +899,9 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_memtostr),
 	KUNIT_CASE(string_test_strends),
 	KUNIT_CASE(string_bench_strlen),
+	KUNIT_CASE(string_bench_strnlen),
+	KUNIT_CASE(string_bench_strchr),
+	KUNIT_CASE(string_bench_strrchr),
 	{}
 };
 
-- 
2.25.1

