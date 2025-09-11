Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9492522B4
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592891; cv=none; b=Xopk2JTGWTTtjlK1Q1muRNojN0HoKM0S2U7t64C+TLZ3WaRiNjCchQ6u17wQaLFWTjBbFd3LwAZaQc4O0LFwHZ8DdDtq28kR8NtUCH1QmKWtYrZn6OmbtC45HvpZU9rjnL1dSsM8cTprrcfPF0XWpJlMsEQpzV1Pe2r3fkqPQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592891; c=relaxed/simple;
	bh=2sO+DVZXh/7ePgmsdKci7CudQiQa4F9VcP5LQIwNDEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oc6m05ba8dWHdWzPbV3xO1hZUBqpTJNVMKYACVZiRJuoqzSVCSWvumMzv8Ak14pkYYYP/fjIgo6MUqYevfekqvnVP4blZ84W80Ptwf50S8Yq8zf+aY+SIlZxi4wJHk3N6p7pf9uYb8+y+NH6BZmR84pEtrDMJ+AIDFOc6LRA+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oYWNWnOy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oYWNWnOy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757592887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6jY+NSNeTG1AR6VFAUnjneRpFWvTY45p03yTsBUBKrk=;
	b=oYWNWnOyhcIl2n4JD9ChJ/OOC5sdFHBkU0lPggQSC4aN99Q4shUApo01da/F4xe/xXezhu
	j8rTNZIX0DNsr8cq0n0fFyDtwc5X5iwqThWdAYj+2TJ+KNTGr9nzd2vD9G64TZ4QzFpVzV
	m90V6Gnx5upnms1jAoipRfv4o6pnAGw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] x86/olpc/xo15/sci: Replace deprecated strcpy() in xo15_sci_add()
Date: Thu, 11 Sep 2025 14:14:05 +0200
Message-ID: <20250911121407.1388703-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/platform/olpc/olpc-xo15-sci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 68244a3422d1..82c51b6ec528 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -7,6 +7,7 @@
 
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/workqueue.h>
 #include <linux/power_supply.h>
 #include <linux/olpc-ec.h>
@@ -144,8 +145,8 @@ static int xo15_sci_add(struct acpi_device *device)
 	if (!device)
 		return -EINVAL;
 
-	strcpy(acpi_device_name(device), XO15_SCI_DEVICE_NAME);
-	strcpy(acpi_device_class(device), XO15_SCI_CLASS);
+	strscpy(acpi_device_name(device), XO15_SCI_DEVICE_NAME);
+	strscpy(acpi_device_class(device), XO15_SCI_CLASS);
 
 	/* Get GPE bit assignment (EC events). */
 	status = acpi_evaluate_integer(device->handle, "_GPE", NULL, &tmp);
-- 
2.51.0

