Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930ED12BF23;
	Wed, 10 Jul 2024 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653357; cv=none; b=nfoI2fpWESnQ5Fc/PfqV8hPiBILnHlQqAgLAE//qFKmojKS0xZlVNk9BJdU7XWPNQMcOUzczDCxL+74YrK5F9uZW4BGYKD3+qJqqBLCRCyesZArelnuhZYLUZLrxHZLAPjUKjuvuvlq0d4Lt4bqODo0uAESVz3jEEZU+EBJr2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653357; c=relaxed/simple;
	bh=12K8PkjgAlf4Yy3Ph2YxFc15bLk8RLBUzI3Tg0Ee4Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XSUcmWOqY54u6VaciDrw1Wh5eOuqklcPOgHb5p+8uqYw8uEVefKzu0DEtEF+LyPvLy7dciNdvJ6u9zcSSLQtWoy1wzB4e7hhNK56gUVU7zgZsK2Wdih/JmLdyt2Nky15UTGKseqPV4nIf7i3lB0Z6x9KSeYfA/FBoEhNDigB6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPw1nJ9F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPw1nJ9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AB6C32781;
	Wed, 10 Jul 2024 23:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720653357;
	bh=12K8PkjgAlf4Yy3Ph2YxFc15bLk8RLBUzI3Tg0Ee4Y8=;
	h=From:To:Cc:Subject:Date:From;
	b=IPw1nJ9FWyMJ6rTcVV6mwP+n/EHVO/hu/nsrqzc5cpIKH1VmmBUEnw8iFlpOkTzUR
	 UktTExsVFBCeg/uyY6vOrV2NGrq2d8X/85c72WrOTEqSPDgnnrWemCyh4ccEtYXZO2
	 vOqUcimb9vciIKCk2SD+sFO2+Ovcp80ogM6I+Hub7W3LBI1kExXbGNztdepzhSod0o
	 oPUdgbonjSRFK1D/alPJDZpWDDy+Zxbj/LP/67xrdFINUBS7AIU1Xyct4+vajBk8EK
	 pWSnYVdDq/gdOa+8GQuXw2heWfUnuOaBirvuJArr318gd7rej2RuKK+00eYeNRklLB
	 jW4zR0VCvjEWA==
From: Kees Cook <kees@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virt: vbox: struct vmmdev_hgcm_pagelist: Replace 1-element array with flexible array
Date: Wed, 10 Jul 2024 16:15:55 -0700
Message-Id: <20240710231555.work.406-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=kees@kernel.org; h=from:subject:message-id; bh=12K8PkjgAlf4Yy3Ph2YxFc15bLk8RLBUzI3Tg0Ee4Y8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjxYrQFvg6Myp/dqaxd9c1I9SQeTAOBna3TgY/ 4ZwxFwY9FKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZo8WKwAKCRCJcvTf3G3A JhwQD/9gHHrHq9XVc3JrCq1py5D/rZjBDuIAIorvUWWAftf+AI6Ksg43Ttb42ARYdOkuP9uwy8Y QNleZEenyiyFmgrad+UruCXN6KM7esTqmYRaXkxKgP9Garf/rusUyNAJdT2MCqr7w37GECSjBLZ 5a7EC/HBYrT2NWFY8VExq3HDwrNFouM+/MI3tvt72oWzP/3EHb49JQ3mENBeVhtC+83TzgziGHr xFuiBc3TPskKcJFF9a8iXQIT7c+kzJvGR/KZglwyu7sKK9Hpw2kYzA8YmNWVSwNH0ScrLWJgrzg S43C4Sq4Dxc9jJUYatAhzCNckZiduDETM0QVbvxKaZI4T9Cn05sbSoXCqJl0GICFPHC4Dwucqr7 0/yxlNdrlRL+ftuNizQkh3okzMG36oQDg7+t4oAR6tCFkQYlNtF9k3opPhbFd3GmF7IoWzUGFne arkW1v8LpAWfg32vYIYF0svYCISOJQwG89/QWeWCQ/EeFrrE/eQSYOWIOXEtfSQWV2aWeV4Dy02 YT6pRATV4x6CmM30+ut72yKua7sknXZ/sdAADpDWpXecIwIKz7q9ijWzErGllaB/lrJL9pG1A5x Sj2k8Bi9taR6NsEDPOdNr6xIYwfCiQa/WKEnI/B/ryeTXEogvONqN7xJiT0Hh4TAKuFn8eUaKQI fseDqnnoOUllh
 lg==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace the deprecated[1] use of a 1-element array in
struct vmmdev_hgcm_pagelist with a modern flexible array. As this is
UAPI, we cannot trivially change the size of the struct, so use a union
to retain the old first element's size, but switch "pages" to a flexible
array.

No binary differences are present after this conversion.

Link: https://github.com/KSPP/linux/issues/79 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 include/uapi/linux/vbox_vmmdev_types.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/vbox_vmmdev_types.h b/include/uapi/linux/vbox_vmmdev_types.h
index f8a8d6b3c521..6073858d52a2 100644
--- a/include/uapi/linux/vbox_vmmdev_types.h
+++ b/include/uapi/linux/vbox_vmmdev_types.h
@@ -282,7 +282,10 @@ struct vmmdev_hgcm_pagelist {
 	__u32 flags;             /** VMMDEV_HGCM_F_PARM_*. */
 	__u16 offset_first_page; /** Data offset in the first page. */
 	__u16 page_count;        /** Number of pages. */
-	__u64 pages[1];          /** Page addresses. */
+	union {
+		__u64 unused;	/** Deprecated place-holder for first "pages" entry. */
+		__DECLARE_FLEX_ARRAY(__u64, pages); /** Page addresses. */
+	};
 };
 VMMDEV_ASSERT_SIZE(vmmdev_hgcm_pagelist, 4 + 2 + 2 + 8);
 
-- 
2.34.1

