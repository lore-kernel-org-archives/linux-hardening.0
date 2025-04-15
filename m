Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C7253931;
	Tue, 15 Apr 2025 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758869; cv=none; b=E5mLD3AuRhWaoOW3mdJ7FLzcFph5tifKxcaX66sfqJg27/iWQo0vxesKjn/a30nxYK+g1bnwA6MEWN/9zhFc6cnjdSd3XmTTBA8iVwTeS76vfJ0ufRn3T/pysGqfH5qeLnq8KHoqEpCkO4GggDhNlYK0MQgjRgTe7DDdfBEF2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758869; c=relaxed/simple;
	bh=QmJhEr5w11nstQmKoltwJY506M/d/M2HxIyu1/NjuI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F6mNz4wScoliragN+eAHNTM8MlQbgcIAdbCXkq1UuQ7+NNQD32LnNBq8M90wB2K1ZYBp68AiAVDVZAv62IPTuTkhLJ2xt586ua5IkV6PjqoLTi7pvKymC/NUKxupu5mcuFYtYM00IKI7lTUELR6JhGO5+LY/K6AqKaRV+aQJo1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ/Wh0uv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ/Wh0uv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38E3C4CEE7;
	Tue, 15 Apr 2025 23:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744758868;
	bh=QmJhEr5w11nstQmKoltwJY506M/d/M2HxIyu1/NjuI0=;
	h=From:To:Cc:Subject:Date:From;
	b=ZJ/Wh0uvmSLqLmS+Yt0BJLeV+O4cFAkGrsIJhJalzPjSpePJ7P/rdsYhQT20qB0vi
	 PK0hCDaj93Cu/35cRclh96JcBwzHCkJOxNgDHU0YCH0ObMEsG+2PGd/AAPy+ktt77v
	 L3OH7gcb17EjzgC2RyBXCmrvzhy6j80k5YcQvN5Sk1DiwEU1a28j6R6UJjr5Etv5un
	 XPW8XGIWsJ6vOJy0Uo3SenlrCYK8Mxv2sirMzHbb4nuPwS+6HiAq+JV6dzz51yN6uu
	 YWXbuhLP/UwZQrV6b5/z2NN+6oG9CCUoWp/J5vrrO/YD1VRK+vyqhfYbGuIGY2Q/8t
	 KsybhVF4snLvg==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mod_devicetable: Enlarge the maximum platform_device_id name length
Date: Tue, 15 Apr 2025 16:14:24 -0700
Message-Id: <20250415231420.work.066-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3946; i=kees@kernel.org; h=from:subject:message-id; bh=QmJhEr5w11nstQmKoltwJY506M/d/M2HxIyu1/NjuI0=; b=owGbwMvMwCVmps19z/KJym7G02pJDOn/XgQ4fma0S075VbVe8dqT0OzNxkZrLh54xLs0vGmP6 h/LUKOKjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIn48DEybDX9YHPkZnBff/mx q6J9ysbWz8WXTji47tXB6MfVDY+1hBj+KfLdV7RPqv58+IiU4qk575ui9Kq1Zon9aMlJYhJp2m7 DBQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The 20 byte length of struct platform_device_id::name is not long enough
for many devices (especially regulators), where the string initialization
is getting truncated and missing the trailing NUL byte. This is seen
with GCC 15's -Wunterminated-string-initialization option:

drivers/regulator/hi6421v530-regulator.c:189:19: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
  189 |         { .name = "hi6421v530-regulator" },
      |                   ^~~~~~~~~~~~~~~~~~~~~~
drivers/regulator/hi6421v600-regulator.c:278:19: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
  278 |         { .name = "hi6421v600-regulator" },
      |                   ^~~~~~~~~~~~~~~~~~~~~~
drivers/regulator/lp87565-regulator.c:233:11: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
  233 |         { "lp87565-q1-regulator", },
      |           ^~~~~~~~~~~~~~~~~~~~~~
sound/soc/fsl/imx-pcm-rpmsg.c:818:19: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
  818 |         { .name = "rpmsg-micfil-channel" },
      |                   ^~~~~~~~~~~~~~~~~~~~~~
drivers/iio/light/hid-sensor-als.c:457:25: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
  457 |                 .name = "HID-SENSOR-LISS-0041",
      |                         ^~~~~~~~~~~~~~~~~~~~~~
drivers/iio/light/hid-sensor-prox.c:366:25: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
  366 |                 .name = "HID-SENSOR-LISS-0226",
      |                         ^~~~~~~~~~~~~~~~~~~~~~

Increase the length to 24, slightly more than is currently being used by
the affected drivers. The string is used in '%s' format strings and via
the module code, which appears to do its own length encoding. This size
was chosen because there was already a 4 byte hole in the structure:

struct platform_device_id {
        char                       name[20];             /*     0    20 */

        /* XXX 4 bytes hole, try to pack */

        kernel_ulong_t             driver_data;          /*    24     8 */

        /* size: 32, cachelines: 1, members: 2 */
        /* sum members: 28, holes: 1, sum holes: 4 */
        /* last cacheline: 32 bytes */
};

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>
Cc: Nikhil Agarwal <nikhil.agarwal@amd.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/mod_devicetable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index dde836875deb..6077972e8b45 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -601,7 +601,7 @@ struct dmi_system_id {
 #define DMI_MATCH(a, b)	{ .slot = a, .substr = b }
 #define DMI_EXACT_MATCH(a, b)	{ .slot = a, .substr = b, .exact_match = 1 }
 
-#define PLATFORM_NAME_SIZE	20
+#define PLATFORM_NAME_SIZE	24
 #define PLATFORM_MODULE_PREFIX	"platform:"
 
 struct platform_device_id {
-- 
2.34.1

