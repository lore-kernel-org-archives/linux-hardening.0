Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97777C77B6E
	for <linux-hardening@archiver.kernel.org>; Thu, 13 Apr 2023 14:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDMOmx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Apr 2023 10:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjDMOmv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Apr 2023 10:42:51 -0400
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C649EE7
        for <linux-hardening@vger.kernel.org>; Thu, 13 Apr 2023 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681396529; bh=ZRwoNHCg3Qd6/SU6rWpni4uie/z3q0bDcBsHnvyXoD0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=IbVEGk91ztnZ+47BMUBsxTxOYRUaYXQM3xw1MUyNnvMBeNMgpH8n0hqp5WqJ9llvv
         VwTWDZesBKLMI8xU3zlvRAztgafz8YArYnW4yg3knQ+q3tqSskC6vrtjrKSVeMo188
         1VP5F/OisCKxZwgA22Yob7qMlkXKZJR4eB2VuTnX+a5uVP9xk/JGvIc4WRjUCtWFOH
         CrLSbmDL9K6QQqY0r9xJWZ24N5XNVVp7hBahkY6aBLpem7uWdTHFOCTbKg6dOlCAKv
         cAQs4MG0ibFSP63WAPHIWbN4R1teZXsPZ2jWt2VB/+H0gONtXIiRF/ZB5BTbmBK/t1
         nvhigtdx8NYVA==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id D5867180940;
        Thu, 13 Apr 2023 14:35:23 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH 0/5] Some tiny clean ups for SLUB 
Date:   Thu, 13 Apr 2023 22:34:47 +0800
Message-Id: <20230413143452.211250-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Fyx9MUGIrZKbkGwvJjlWiGQSd2t9Nin6
X-Proofpoint-ORIG-GUID: Fyx9MUGIrZKbkGwvJjlWiGQSd2t9Nin6
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=526
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2304130130
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

Hi,

Just clean ups, no any functionality changed. Thanks for your time.

Xiongwei Song (5):
  slub: Correct the error code when slab_kset is NULL
  slub: Put objects_show() into CONFIG_SLUB_DEBUG enabled block
  slub: Remove CONFIG_SMP defined check
  slub: Remove slabs_node() function
  slub: Don't read nr_slabs and total_objects directly

 mm/slub.c | 45 +++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

-- 
2.30.2

