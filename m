Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987124F4032;
	Thu, 17 Sep 2026 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679621; cv=none; b=BWRxCtvC4UAisTJShrnqLjCO9k+rYjThcBkSG3xQqWWVt3pjrrT8KelwsPYSlCGxfeXBaPdhleUUqmK7EK0WIOsEAAbZmMNHDOUkP/lT6fl1DQmmVbzZ5kNDhpVJcrn0uxnFCzbO2k9ikcoOHpWoRxVrj+I4pXO8RFTw+wgmj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679621; c=relaxed/simple;
	bh=n+QIvw4mOdZUBH8xJz0pRkwthW6Jc48x7rCNVbzDafs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CVpv4QVJSvlNTVafYfFXt7hZBXXANPsrsmElcG8zHRoJ9/1EV/0ft8KicGroytcurFxcwU/4lwNF+jsNd+dLWKIwyJiL4Pu00VW/xRM014GenAk7CtsYOGK+RSgIvoFGkrC519amMXarPKRqml2yWtwP1FLcYWQQqakOGHCNPYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZPQhrR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZPQhrR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9A31F000FF;
	Thu, 17 Sep 2026 21:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679620;
	bh=u8OCOpSM7mteZ0N5t2ckV/I4v5WZiImemRorl7VyJzw=;
	h=From:To:Cc:Subject:Date;
	b=oZPQhrR6Nxtvqa03dt7wG5SAdt1gtvHC261STLD6eiPqsYAofhdUg/oM0N8qjaX40
	 Ugne0TacUyvlSJcBZsyYX3Xvte7Fyjw8ZQej3tjz0gev2opqcH6gwRpE5fF3qGmK6I
	 c8azfSJnxip201kIeYU5G+q0g/jqXS8c8tSpQXCjAJ/lMfMA6SHR63OmjRa9eKkzOI
	 QY8lZBDBj1HoLJOdVwW1Oj0ZHIhfdVk+ptl14KL2ayYCd7F3l7zuI0h0rjY0TvTslD
	 W/7iIGYESFTrojQccd5Xe5t+1JgeoUCVgC9ogDsalDAf/HpT3L6OK9U5eHTTA9XFEO
	 Rn5OgTANMoVRA==
From: Kees Cook <kees@kernel.org>
To: James Seo <james@equiv.tech>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] hwmon: hp-wmi-sensors: Fix info_map[] allocation type
Date: Thu, 17 Sep 2026 14:13:39 -0700
Message-Id: <20260917211338.i.682-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558; i=kees@kernel.org; h=from:subject:message-id; bh=ByltX2iSuB/OVnrpO5B1imLbJlOZL6RPibWPxu8F4Hw=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrIpi4/8Zs+N3t1lFz6k6PUtqVg8prQ+Y8aTlpcGaWZ FZ7i4BCRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQ07zH8099gFDlvee77/d6P Jy1uLxTL+5SYofdRvWFOS7iS2db5jAz/C2evWKGn+/Cm3duNnqelm1ee42ZUCZ6x9V3POpk335k KeQE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type of "info_map[type]" is "struct hp_wmi_info **", but
the converted allocation type would be "struct hp_wmi_info ***", as the
size was taken from "*info_map", which is one level of indirection too
many. Luckily both element types are pointers of the same size. Take the
size from the element type of the assignment target.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/hwmon/hp-wmi-sensors.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: James Seo <james@equiv.tech>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: <linux-hwmon@vger.kernel.org>
---
 drivers/hwmon/hp-wmi-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
index 03c684ba83bd..cc193a8890f2 100644
--- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -1788,7 +1788,7 @@ static int init_numeric_sensors(struct hp_wmi_sensors *state,
 
 		if (!info_map[type]) {
 			info_map[type] = devm_kcalloc(dev, channel_count[type],
-						      sizeof(*info_map),
+						      sizeof(*info_map[type]),
 						      GFP_KERNEL);
 			if (!info_map[type])
 				return -ENOMEM;
-- 
2.34.1

