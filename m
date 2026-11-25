Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604635;
	b=zGhZMAYdblmJCe07cokqp3ghk+7uqUHAtpfzK8VRQeMZjuBARz9yBgCJHegfu+khZOFt
	 +52oJuK6OXAN8CHMK/qW0H8zogdDQLE5OmAF+CEkSDepw3QUFHp1kdlgkYNyHJVTNV1Fc
	 edMm4cpA5ggm/PH4l/a2oxmz+Px/Z3QDHAnY6G/dRqbyvPbH5jN5foL9nqzm2CMA4G/BX
	 dwZ3lmGSeoy2gV5pwIenQLMROWbaNtmijXcn5mTR/PDWH5WQTWyNCUc3WEFIF+87tx81m
	 tEyTHJ8UeskDaDEdRfDc2AbNYRDvJfExCi8NWUDKQMWUW+UVEuwQpI8lzqX3dpaaVIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0kNQWd4xFKVKn6MSVwE1lsRc4X4V5piL50Xtk3okz4Q=;
	b=vkSk8MxNVLVinu2JGpBOM+b/Ss3D7tqXiwiAs/hz3eY5+Hc975ho67L8nOB6xFtT2GES
	 4veEH9ScrMy35qsx08CZo2gK525wSQ11deKLfuaZBLWPmi7brp2WdNqSDWdU230dP9CeK
	 idBtQ++2NOK+DiGBZX18RyTJN5DOZfsKkxt10jTBoSfA6vzQd2KaBGoh+OkPveWogEXtW
	 zRBSEG8dk8M7IeRYRJCkVjxjNHjUiI9gkMf9VQNOFXGQujvH+IoF5IpJCzhrE8pjTExw2
	 SIQmIpxacEYsZLzRQfbu5yWWvYzh6C7BHJUIYBH+Vay9iFEhfGh21mEJATUSmo7aP3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tEJETcDI;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96125606A33E
	for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 11:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96125606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tEJETcDI
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-386c71feeeaso1893379eec.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 03:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795604634; x=1796209434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0kNQWd4xFKVKn6MSVwE1lsRc4X4V5piL50Xtk3okz4Q=;
        b=tEJETcDI9nkCss/hKuXkAaC9GvIz08tJYkSrVU4Oe69bDT0B66YUaL+J69XjRnBVMD
         Ahp9NLL1bEKf6C9NL6GGrrzrPU2zSHu3En0rsnhcf2usHpCDfyQWDyHFUGUQlLEetzte
         /fgEt8ue46CS7/fi9c0QHCJ1zMmjpviN/o83uV9sIDP38eWQ+NO+kU0id6Gt41JKOQUs
         1KurRA9D8cpc2/QU2eRf5F66A6AJ7/9niMKrjpiIg8pxK28Mg+Vbkx9/7HjPtkDqX+xO
         C7i8OI7DcesHsNNnD+jgPDxNijanItWp8h0zKHYWDgHGLxptDPhsIfMFCd+PZCDXAwUR
         ZnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604634; x=1796209434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kNQWd4xFKVKn6MSVwE1lsRc4X4V5piL50Xtk3okz4Q=;
        b=2hl/6S4WTCX9ufJ0U5a3K4IBYfdU2Ff6LDn6cOV3WIlntabeczbm4r87t70PN7Om4G
         OgvFa9pgAXgktoEotDt/DdnsqjDfvzrggNgZaqL6QKShcUcq1YfckCGw91xcFQHgWRTZ
         +zV6RS85h/P0yNZbq2lnQi7PJmxKgEYzvoYqXrBjirI99Nd2eXKSb/BtCoeJ6I09nbJQ
         fG6uuGa5bbkVbjelsWu1hAUH/7DQw61Uwu5+zdnV+ZhjpC87EFXipaAEZPK7MFUw4Bv9
         JhajlwEreiZJNF1lbqG8AL+pPhh+rUNup3L3LacmtDaLMFv80LgbcQruTg/arARkNzyO
         G3Og==
X-Forwarded-Encrypted: i=1; AL+hErE3Ba5t3a9p+I3HIf3dRzw2+LrjoKvtgJruo9l/gLqGOK9Fxf8hxo2JOEn5AH933Mc4mAY52Zd2Xivkg+5pjSs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AB4sSYooGrgwqa7RcXLjbvOPo+3nT7j8CeAz/1j3NPXRcswlz
	4OdMECchO91vOUzOLNeAq7QURShATyeyitmg1EuSTa0N8w9maxXbmDJRAYOBYaqP
X-Gm-Gg: AZFdTZeLW8udqz+oY3NU4riu89DKxW+ctsRTc2e4LArcj1XLTEMtqBffDBVDSivqcjK
	8zQymOafHX34tDKWJRPFmHW5qO7k7wNK3/PmyruWyinGuDSayZFLse2sq+AnkytoabGUA17+O5J
	c/AQPFjLIqFtnqUpPO+8nkW9e9VXg+6ey3v72/GwacIYgUUXITLrpQgbNi3wNEdgUi6V6ByYdzn
	5WCCmh6bOpdjpRAvgCqu6yUW+fWhkwfK6OJE6NAPEjGoKZVW4ILIr1dIE3/OHJThkNaW5KR7NkN
	bqAUUXJJ/78zfObSE6b5sBE9DsDgvfwyFrXMRheWQhWlj33c7P/wnJJ4+Bc29JI0gPBA6/I5dL1
	FXifWOVPOU2eYy3+VQXQZ92jAwOODys2LITbS6iqN/1leAmtKvgZSWUYK7C9QOvDYLiqgyKXaw7
	dsvrIw3ZtP/qooyBForpYbgZpRmrkYXgDq5fLruWw9G+agPcLD5DR0Fv+7hr/2tRuPfsRCxn4yM
	nLSCcMMBq/8CYaVGj/m0rgkOz0trH8KbyYm4Yrv7A1zgsGDas4ozadmLCimWF6zgpa3D/LAuMke
	j/F+C4vRT4EBCl1g+5irEWf9toPbbNICLBxM+WRQ9dvB6mDajiAt8Y8hFs8/QiO4j4QZCiGNyg=
	=
X-Received: by 2002:a05:7300:ce8f:b0:375:7be3:1bbd with SMTP id 5a478bee46e88-38570b336f4mr16085568eec.23.1795604633460;
        Wed, 25 Nov 2026 03:03:53 -0800 (PST)
Received: from BenDellReactive ([117.20.154.221])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm49317327eec.13.2026.11.25.03.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:03:52 -0800 (PST)
From: Benjamin Dornel <benjamindornel@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Dornel <benjamindornel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: iwlwifi: mld: fix net-detect wakeup report after kzalloc_flex()
Date: Wed, 25 Nov 2026 19:03:47 +0800
Message-ID: <20261125110347.884775-1-benjamindornel@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj
for non-scalar types"), the net-detect wakeup info and its matches are
allocated with kzalloc_flex(). Both flexible arrays are annotated with
__counted_by(), so on compilers that support __builtin_counted_by_ref()
(clang >= 19, gcc >= 15) kzalloc_flex() also sets the counters,
n_matches and n_channels, to the allocated sizes.

iwl_mld_set_netdetect_info() still uses those counters as the next free
index, so every match and channel is written past the end of its
allocation, matches[0..n-1] are left NULL, and the counters end up
doubled. cfg80211_net_detect_results() then dereferences matches[0] on
every net-detect wakeup that reports a match:

  Oops: general protection fault, kernel NULL pointer dereference 0x20
  RIP: 0010:cfg80211_report_wowlan_wakeup+0x46a/0x680 [cfg80211]
  Call Trace:
   iwl_mld_wowlan_resume+0x9d9/0xe40 [iwlmld]
   iwl_mld_resume+0x1d/0x50 [iwlmld]
  Workqueue: async async_run_entry_fn

(0x20 is the offset of ssid.ssid_len in struct cfg80211_wowlan_nd_match.)
Without panic_on_oops the machine is left wedged mid-resume.

Fill both arrays using local indices and store the number of entries
actually filled in, as iwlmvm already does. Also stop setting a match's
channels when they can't be reported, rather than leaving n_channels at
the allocated size, and report the matches found so far if an
allocation fails instead of returning with n_matches unset.

Seen on an Intel BE200 (iwlmld) in a Dell Pro 14 Plus with kernel 7.3.5
built with clang 23, with net-detect armed via
"iw phy phy0 wowlan enable net-detect interval 10000 matches ssid <ssid>"
and that SSID in range during s2idle (also with pm_test=devices). With
this change the same setup reports the match and resumes normally.

Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Dornel <benjamindornel@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 77e4850..e67a22a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1423,11 +1423,11 @@ iwl_mld_set_netdetect_info(struct iwl_mld *mld,
 			   struct iwl_mld_netdetect_res *netdetect_res,
 			   unsigned long matched_profiles)
 {
-	int i;
+	int i, n_matches = 0;
 
 	for_each_set_bit(i, &matched_profiles, netdetect_cfg->n_match_sets) {
 		struct cfg80211_wowlan_nd_match *match;
-		int idx, j, n_channels = 0;
+		int idx, j, n_channels = 0, n_set = 0;
 		struct iwl_scan_offload_profile_match *matches =
 			(void *)netdetect_res->matches;
 
@@ -1436,10 +1436,9 @@ iwl_mld_set_netdetect_info(struct iwl_mld *mld,
 				hweight8(matches[i].matching_channels[k]);
 		match = kzalloc_flex(*match, channels, n_channels);
 		if (!match)
-			return;
+			break;
 
-		netdetect_info->matches[netdetect_info->n_matches] = match;
-		netdetect_info->n_matches++;
+		netdetect_info->matches[n_matches++] = match;
 
 		/* We inverted the order of the SSIDs in the scan
 		 * request, so invert the index here.
@@ -1451,17 +1450,21 @@ iwl_mld_set_netdetect_info(struct iwl_mld *mld,
 		       netdetect_cfg->match_sets[idx].ssid.ssid,
 		       match->ssid.ssid_len);
 
-		if (netdetect_cfg->n_channels < n_channels)
+		if (netdetect_cfg->n_channels < n_channels) {
+			match->n_channels = 0;
 			continue;
+		}
 
 		for_each_set_bit(j,
 				 (unsigned long *)&matches[i].matching_channels[0],
 				 sizeof(matches[i].matching_channels)) {
-			match->channels[match->n_channels] =
+			match->channels[n_set++] =
 				netdetect_cfg->channels[j]->center_freq;
-			match->n_channels++;
 		}
+		match->n_channels = n_set;
 	}
+
+	netdetect_info->n_matches = n_matches;
 }
 
 static void
-- 
2.56.1

