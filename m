Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14C3D3CE6;
	Wed, 25 Feb 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041626; cv=none; b=Gcw0XXPgWNc08NkngLyT5Mns/2DHoTLTH2qwJaOKQDlK5siogNmW4VCp7AfQyTxyPtd9NuSNwo/haoklus3MYGMbXvOvGHfaEbvuJxkrhrwTZ+JltzoEu4fEfQH8jJevwk8FTIuj17MgQlTrgLWl3MXEM5PjDcbrt/8ZNW00f7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041626; c=relaxed/simple;
	bh=3kES5koMMsOOveBPxWed4CGDwckWaezMzM1U4NZbmGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lOgzyQ2VUwFepZFopm2x4WesAyuAYYQvHukHwkZiSGrKpmnZLd1pgjuWSSFmJlhCPelasBaEFTVHjztekrFd7wdw2L+On7UalG4KGAA508K/iFN2ppW+uyInvDctVZvQTb9RVXekVnPtWmR7ualZNDFW0oNEwZ1WnoVCqfcAVi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scycDjy7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scycDjy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF03EC116D0;
	Wed, 25 Feb 2026 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772041625;
	bh=3kES5koMMsOOveBPxWed4CGDwckWaezMzM1U4NZbmGc=;
	h=From:To:Cc:Subject:Date:From;
	b=scycDjy7y+yijVjgfP2u1s+aM+ah3eO9RgVaAl8dHbvWYfIhFLa633aymmFbaerfe
	 SpTqZJ5weJxA0JckNxAubDr1K4VeO3bs2E5R3L66cB6pj5lU/4AUXIsBmEuOGN9PcB
	 MiI8V++NVHtBoKbmqr9uHAi1BZoVKuo3Z3rc4zuGLexZGCZ0JnVY5LSdboWv/rfD/N
	 BHSAOnxgFO+9sGKntB12oalkhdcA+1v0CknhyGA3MSWbNcmYJVa1TPo6bTKlXghWbk
	 N/k2rBIqdMHhopoxMAlZNvXzJKisfY+wEmIFEBDM8LoufMsEWwUWy+xyudTXibn0tW
	 MVJbLwuHziBKQ==
From: Kees Cook <kees@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	YiPeng Chai <YiPeng.Chai@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] drm/amd/ras: Fix type size of remainder argument
Date: Wed, 25 Feb 2026 09:47:03 -0800
Message-Id: <20260225174702.it.918-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3415; i=kees@kernel.org; h=from:subject:message-id; bh=3kES5koMMsOOveBPxWed4CGDwckWaezMzM1U4NZbmGc=; b=owGbwMvMwCVmps19z/KJym7G02pJDJnzTafpqa/NSVmixSh3xmHKu4kvwiSEHt3Ps2hSu/jy+ aGcz9f3dJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExE5TgjwwHlB3Fqax5HzHL4 X713OtuOyqXVZw7IXj8y6823fPOXsw8wMnS89n3xUah/l1rPHc+CF08NWe7dMlCNZrILN1gh8GH den4A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Forcing an int to be dereferenced at uint64_t for div64_u64_rem() runs
the risk of endian confusion and stack overflowing writes. Seen while
preparing to enable -Warray-bounds globally:

In file included from ../arch/x86/include/asm/processor.h:35,
                 from ../include/linux/sched.h:13,
                 from ../include/linux/ratelimit.h:6,
                 from ../include/linux/dev_printk.h:16,
                 from ../drivers/gpu/drm/amd/amdgpu/../ras/ras_mgr/ras_sys.h:29,
                 from ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras.h:27,
                 from ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:24:
In function 'div64_u64_rem',
    inlined from 'ras_core_convert_timestamp_to_time' at ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:72:9:
../include/linux/math64.h:56:20: error: array subscript 'u64 {aka long long unsigned int}[0]' is partly outside array bounds of 'int[1]' [-Werror=array-bounds=]
   56 |         *remainder = dividend % divisor;
      |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c: In function 'ras_core_convert_timestamp_to_time':
../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:70:19: note: object 'remaining_seconds' of size 4
   70 |         int days, remaining_seconds;
      |                   ^~~~~~~~~~~~~~~~~

Use a 64-bit type for the remainder calculation, but leave
remaining_seconds as 32-bit to avoid 64-bit division later. The value of
remainder will always be less than seconds_per_day, so there's no
truncation risk.

Fixes: ace232eff50e ("drm/amdgpu: Add ras module files into amdgpu")
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: use temp u64 to avoid 64-bit division later
 v1: https://lore.kernel.org/lkml/20260225024716.work.043-kees@kernel.org/
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: <amd-gfx@lists.freedesktop.org>
Cc: <dri-devel@lists.freedesktop.org>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 01122b55c98a..02bbee64a5bd 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -62,14 +62,16 @@ int ras_core_convert_timestamp_to_time(struct ras_core_context *ras_core,
 			uint64_t timestamp, struct ras_time *tm)
 {
 	int days_in_month[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
-	uint64_t month = 0, day = 0, hour = 0, minute = 0, second = 0;
+	uint64_t month = 0, day = 0, hour = 0, minute = 0, second = 0, remainder;
 	uint32_t year = 0;
 	int seconds_per_day = 24 * 60 * 60;
 	int seconds_per_hour = 60 * 60;
 	int seconds_per_minute = 60;
 	int days, remaining_seconds;
 
-	days = div64_u64_rem(timestamp, seconds_per_day, (uint64_t *)&remaining_seconds);
+	days = div64_u64_rem(timestamp, seconds_per_day, &remainder);
+	/* remainder will always be less than seconds_per_day. */
+	remaining_seconds = remainder;
 
 	/* utc_timestamp follows the Unix epoch */
 	year = 1970;
-- 
2.34.1

