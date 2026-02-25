Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB328489E;
	Wed, 25 Feb 2026 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983800; cv=none; b=GGPxBXlL5Y2KZi5LPWk+e0Ti2JQ4zTjccrOl6z7KgHmjPXacERvSYmjXZ25m8whWYZwFqQm0ezzwoSsDkRLsigY1TzM3H2JXh33MaS53av0bQVB1EZU+D2R95fVhtEPyyVpqt30ZZytvtAM5H0K5YpnQCvZHsCp3IdM6iaEBueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983800; c=relaxed/simple;
	bh=Nmr6hflCYeyKGPgmpGenCkgbLWBwwqrgtfuM+FOG3fI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PQt8WXVgYE/jHYncwRMIg4PgfKAgztCKAbOtXbnymqF7PhWfYxMhr7zv8QEFSMowsYb43GpHH8zpqvv2IuT48ksD/vjmJYaMF+J94qdDea6QQBvsj4uK7Ew0zN0I3PMLET3LybHZYJ9YMRmaSU1ZuWe78m0G9q0mgWeT+CWsbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKnvqUVv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKnvqUVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52367C116D0;
	Wed, 25 Feb 2026 01:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771983800;
	bh=Nmr6hflCYeyKGPgmpGenCkgbLWBwwqrgtfuM+FOG3fI=;
	h=From:To:Cc:Subject:Date:From;
	b=cKnvqUVvZjDtRn0DayjLzm2J0/zqcDaAsqWDZ8h5x4Vngb4krVV6yaviGoXRTlna9
	 TD/jtt8sth6ZGen9JzyyK6RgJBtSdUyDealhnIYaMbDZAbc7iFUAIowhaLaLF73/te
	 2ZmvDHgGL23VIYlsKYelqe1QhpJyQmVvFDe7nRs7ahYQfXufegrqtOLkUjlUYtd+aR
	 f1aVplMebQ+0f7n5w03FjzatYhnAW1OBEU0m2cB+TT2rCy9M7CiRLMgrRAFTkwml7x
	 aBPfG7CMrKsic5pLJY4W0QRa/e5cDqBpdpVJp53X0mhUFEvzSkFAUikl2EYXRx+wRd
	 9dTdZyyBKo4gQ==
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
Subject: [PATCH] drm/amd/ras: Fix type size of remainder argument
Date: Tue, 24 Feb 2026 17:43:18 -0800
Message-Id: <20260225014317.work.103-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=kees@kernel.org; h=from:subject:message-id; bh=Nmr6hflCYeyKGPgmpGenCkgbLWBwwqrgtfuM+FOG3fI=; b=owGbwMvMwCVmps19z/KJym7G02pJDJnzgrcd3bAyo+Dvikj7po8tFmvXMTJylO95fl5W4GxoF otRRVBcRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwETqEhn+WZjvXCzxb7rY0gj5 ME4TpQnKrNFVq3bMneWqcfvOvQfayxkZdvis3JFa+WVm/+tfB46Y6K4Qzl98n938yr87c46KRta oMgMA
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

Switch remaining_seconds to uint64_t to avoid the problems.

Fixes: ace232eff50e ("drm/amdgpu: Add ras module files into amdgpu")
Signed-off-by: Kees Cook <kees@kernel.org>
---
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
 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 01122b55c98a..91e16b0b98f9 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -63,13 +63,14 @@ int ras_core_convert_timestamp_to_time(struct ras_core_context *ras_core,
 {
 	int days_in_month[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
 	uint64_t month = 0, day = 0, hour = 0, minute = 0, second = 0;
+	uint64_t remaining_seconds;
 	uint32_t year = 0;
 	int seconds_per_day = 24 * 60 * 60;
 	int seconds_per_hour = 60 * 60;
 	int seconds_per_minute = 60;
-	int days, remaining_seconds;
+	int days;
 
-	days = div64_u64_rem(timestamp, seconds_per_day, (uint64_t *)&remaining_seconds);
+	days = div64_u64_rem(timestamp, seconds_per_day, &remaining_seconds);
 
 	/* utc_timestamp follows the Unix epoch */
 	year = 1970;
-- 
2.34.1

