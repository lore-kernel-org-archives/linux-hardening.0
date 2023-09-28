Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0272446A5
	for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 02:43:54 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F3D122;
	Wed, 27 Sep 2023 19:43:52 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vt.rlIe_1695869029;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0Vt.rlIe_1695869029)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 10:43:50 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH 5/5] tools/pstore: update pstore selftests
Date: Thu, 28 Sep 2023 10:42:44 +0800
Message-Id: <20230928024244.257687-6-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
References: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update pstore selftests as pstore now supports multi backends

Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 tools/testing/selftests/pstore/common_tests | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/pstore/common_tests b/tools/testing/selftests/pstore/common_tests
index 4509f0cc9c91..f50166f59ec4 100755
--- a/tools/testing/selftests/pstore/common_tests
+++ b/tools/testing/selftests/pstore/common_tests
@@ -73,10 +73,6 @@ rc=0
 prlog "=== Pstore unit tests (`basename $0`) ==="
 prlog "UUID="$UUID
 
-prlog -n "Checking pstore backend is registered ... "
-backend=`cat /sys/module/pstore/parameters/backend`
-show_result $?
-prlog -e "\tbackend=${backend}"
 prlog -e "\tcmdline=`cat /proc/cmdline`"
 if [ $rc -ne 0 ]; then
     exit 1
-- 
2.39.3

