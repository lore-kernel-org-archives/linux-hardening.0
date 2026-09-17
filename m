Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57D54B44D0;
	Thu, 17 Sep 2026 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679660; cv=none; b=MRqkN+AQ/+u0CJeEQ4/EtgHi0DE4lZbmlABd9fZ4WlLKMX/GMzhVRlpR/54QC79pHKWVv4ZiTeogDdyW8qa1lJynl392Ad9uLU0ElBmfPjKknglWWfHN7dfCtpz+EmpYriSy+w0DOQkrbtj7Zmaq/6WMZ5DQwt6jukubqFVotBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679660; c=relaxed/simple;
	bh=guXFARAER5pWz9BdDFppd/C5wi702K4fJO+pG4pn9y8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=McGdmWWXvR7IExzwKBDyTEeE5lm0tESQEkV15V3mXWGTato9JyZ6zMoXgfyqmli1Rl20WOjl2EJAziLiMeDOAvmPGGreBFlqux63WwazGQLdoaJOSro7xOz6xcVxT9ZmKlLSBhAi7srerpYng/O0nu6ovK3KSSVcZ313Ium+juU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3FgLbqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3FgLbqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5521F000FF;
	Thu, 17 Sep 2026 21:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679659;
	bh=er/LdWc/0BQcFdbGsD2kxM5eRSdExfNAs2WhpC8ldT0=;
	h=From:To:Cc:Subject:Date;
	b=m3FgLbqSsrmuCsQZhhKWujPrRP7qpTHpIeWe4VZCb6ZJJQ71SBpMHVBWnUn7i/RrK
	 AzRtXKFjW8ZCmhscj1uu195nNPVMXopYtJTfGi+uUNSvixo4Lnk/Z42EMLfidlMSj6
	 lGxaSEfRM+NhI6nGeJFEGIpVoBlCe6aSR2RAQCRtHZ8hAOZZ1nBe8VO3K8mujusdPY
	 x+xmstmJ3v0LwJxensy5hiTXngirIv0APone6BoIT3xml7S7htPUqiommIR7Bg9nZl
	 rkRzrj7wiE0RO/6RgwbJ6YUGKlJ+5wwtA4g+RaEliDXNzfch8KRxPUPyE/ebkAP7QA
	 87eMk3bAkdI5Q==
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] hwmon: pwm-fan: Add const to channels allocation type
Date: Thu, 17 Sep 2026 14:14:18 -0700
Message-Id: <20260917211417.i.173-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=kees@kernel.org; h=from:subject:message-id; bh=x4xoCWzzqiOvmchlB5MT88JkQ3cygeQwfECTfvUynYs=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrIjSNA2uipnEfCbj100s6acKS810Nl+VmPZbaONPiU 3SZ2edFHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABMxFGdk2Mr8ZJ3YZp/XJYmz Ep36rnh/OcoTHvhObRq3T0DZyvlqMxj+u255ks170aHqSZyET4zov/wHKaIlYlk7L+TVRunKvT3 PCwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type is "const struct hwmon_channel_info **", but the
converted allocation type would be "struct hwmon_channel_info **", which
is the same type without the const qualifier. As there is no general way
to safely add const qualifiers, take the size from the assignment target
instead. No change in allocation size results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/hwmon/pwm-fan.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: <linux-hwmon@vger.kernel.org>
---
 drivers/hwmon/pwm-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 3b87f65bae05..db19a054f4f4 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -613,7 +613,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	}
 
 	channels = devm_kcalloc(dev, channel_count + 1,
-				sizeof(struct hwmon_channel_info *), GFP_KERNEL);
+				sizeof(*channels), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
 
-- 
2.34.1

