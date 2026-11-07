Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794077093;
	b=2PUCt+Zfn/pcG756F1gh5Vl9SecctVtBAh3m5xSq45A4ZGz+76Vz5LBY/xD1dZDfKd2N
	 OVu+9t5+CDPEcxUKlElNA2vYN5TKgg1tMBZLlT9IFtZPrugHUTEDawE4zSeG3eW3wduve
	 v65akXnUTi2+tiDN0lXpCEdeBgMfmc525B8nEajEQcYpl1gfxwneYpSCWk3/7Zx3oekqn
	 qlsNVE56GIQSjwyiAQj4Fw2ZMO/zDUmJCyo7gPFyEL8rPaaGHssBGEgN2XOymk53ZWbY8
	 M6uhGvmwiMSJpmasHUjZ4nWsFBHaXx6o/Q4Ahl2E6x/t06KPoUnOosI0qYg9m71nqdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sg7nmjDxIAixbof136SBr2EkAZqYxcTSKOudRFI2tTA=;
	b=Qdlf0ZzQZa9IvfzyNeFDdeUmkJJpYZWvUOY7pv2QoRV22Jg6Mx/L+BhBCo084AUm8UtN
	 +0YG7IzPBy1Cd38s4dO/aXZjcg3YJPB8PjNfgSOAxhAVckS74BBO1Cx+afu4nUOrpAYKl
	 YFHbreyrBhv09bV3lsBr6ufdiTbyCQJUDO5idJDU3QDBbbERzLXE3q341eNN2KcT6GeFN
	 neefWv32l22e4KNc7TrUmUsQpjpOXC6hNjDlC3CD6ewsocWMKaHItVOUTmCdX1W1DGo/a
	 qOD4yJEijXX85uyqCbHQZJre60EOsrAwaIIAp9IqqnNqehKKhodzmhFF2341PBcoikQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=Vq6K+tl+;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75B606D83A
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 18:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C75B606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=Vq6K+tl+
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2799952eec.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Nov 2026 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794077092; x=1794681892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sg7nmjDxIAixbof136SBr2EkAZqYxcTSKOudRFI2tTA=;
        b=Vq6K+tl+F5g1iN+iqHMArRY4yJWDM7Kpf/2w97t8ACvJdttnXzfxPf4pjTAKDFmrks
         1cM69JKmY33UeLLhn/73sKNx6riqGMLiCLFMWaezg0fdsZLTmAE4CYLCSF91LEyhMWO5
         gkxRiC4r6oXqq+ay3iPEuIcLPHgGeYsou8uukEby9B1VRiptnyG+lep5y935xv/ZnuR/
         /deSgO7k39fdfi+CI1FYdaeqWxkiuIKyHfUaOIooQsFROzlttonXzCujaxqUBjVIOqr1
         fH421UqEXxuQTuAoDMMmi8bQ0sI39qj/2UZbTV+dEjCx+plZp7/yL4a1YMbVsRRRGjqV
         1iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794077093; x=1794681893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sg7nmjDxIAixbof136SBr2EkAZqYxcTSKOudRFI2tTA=;
        b=MQRrOxXcRBRqO/WzuAgjr75/sn0CCjRbNktmT6BECktH+tQHYeAXuRniVct8d2rl0f
         kmfztj5z8bMR0pb38ew1iHqdmZbiw59IHGQfwjyOVZvKsRtpWGg7/1Ld+gebgRn3C2sJ
         ifxYrW8XdI45EEchbfIrBd60/QAT/72oJMPqOSwtA+4aAdpPswLyfwqPPCPlMXVzSVYz
         C7jQXEWBA1YAVwofVLrOyPbv0oQeKPe6WxAQQ5QOTvjoeTAeYO9xORnPWdxvx6yzy1fZ
         ckfRIivwki+15ZuX1XmCfRWnSa6fShErcEGn82JPDZmWlGUQNhxaCd9beAvGgWRV0cy5
         Wqfg==
X-Forwarded-Encrypted: i=1; AL+hErH8aIC5p3hQvcjw/3MNOAGKZ7tzAFN0okaIFMpONVwCmXob5yuTOslEkj/pgzivNZ/FNP5rm2Zkwo9Iwwa8wYs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GNNK6/YEu0jGo8P36VRJBp4/sfgbuBNtqtPeE0Ooad06bhtS4
	aUosPT9RYmSxhaAd8camUryYnmaniL1BdHTmyLcny7PflniQHc5Z3MUpsxlnnyu4A5uwnNC3E22
	fN3HtlK2VvEsl
X-Gm-Gg: AYBFou1NQHVJgActn180iCqR8rZiegq+b/DO5upupBS8X5zaLjhr6BygHTboVzo7oHT
	SJ6RJTCFIIv/N2YUciVTQgUoFedo7wojU2eV1xvp7NC7pIikWCrqiaZqJj1QKZUQuLh4cBZLOD7
	aHphFxm3+uPh5U426BxM5MNxCkqdI5seAGkOgfQUwyI0UxSkxyP7YnSUNzCwq6USTjswE4gK3rc
	2yOg9PQJiGQBuwwCV1bqpmPwiSSx7CCrZrqnSUGTtKOEbv5isMnPuJAQ/kq+fD0N62cdfKHW5Mq
	DE+OUuWgdGOGwPsuA/HGneBWPQvPIKwdFDKRI3+9o/SLsMmxQx4jguUHg2tGG3hWbFgTeE56Kbm
	CJm8iEzJHraGyKGVa0uJ+yNC5YX/SR/XvAKUsHbbv3/2zY/U6nlRDhghoBxNhBs84ntTgL1N1EO
	vjxZDs290Kc+ocMhDSDV00mmWJ2KIihRUZmWBjWJCh8bro9FRXtWb3x0E72aHjYooKd5rAodyBJ
	5zMWmdf/siZlqXtgynFucEIapHBH+Tfb5yr+HCKWsBpIjlbMuWPJe2ivZrh0ml+xC0NUf0cQvup
	rdyml6XCHrNQFr9b054yK0Tkxa/Fksx5F8HpRHN1+9kC9W+Zi3QTi4Ue2GqRtfYwd8M9cLc=
X-Received: by 2002:a05:693c:881b:10b0:351:7ec1:a92c with SMTP id 5a478bee46e88-36f76520e62mr9146148eec.28.1794077092493;
        Sat, 07 Nov 2026 10:44:52 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 10:44:51 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	brett.creeley@amd.com,
	sgoutham@marvell.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	Ido Schimmel <idosch@nvidia.com>,
	Satish Kharat <satishkh@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH net-next 5/9] amt: add IFLA_AMT_OFFLOAD_MODE
Date: Sat,  7 Nov 2026 18:44:33 +0000
Message-ID: <20261107184437.2783174-6-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107184437.2783174-1-omar@blockcast.net>
References: <20261107184437.2783174-1-omar@blockcast.net>
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

software (default), auto or required, after
IFLA_AMT_MAX_TUNNELS_PER_SOURCE. An unknown value, or a non-software
mode on a gateway, is refused with extack. required with no usable
provider on the stream device refuses the link with -ENODEV and extack.
Emitted by fill_info.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c        | 25 ++++++++++++++++++++++++-
 include/uapi/linux/amt.h |  7 +++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 377660e55..58e9da443 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -5719,6 +5719,7 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
 	[IFLA_AMT_NUM_QUEUES]	= NLA_POLICY_MAX(NLA_U32, AMT_MAX_QUEUES),
 	[IFLA_AMT_DISCOVERY_IP6] = NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[IFLA_AMT_REMOTE_IP6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[IFLA_AMT_OFFLOAD_MODE]	= { .type = NLA_U32 },
 };
 
 static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -5745,6 +5746,22 @@ static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
 		return -EINVAL;
 	}
 
+	if (data[IFLA_AMT_OFFLOAD_MODE]) {
+		u32 offload = nla_get_u32(data[IFLA_AMT_OFFLOAD_MODE]);
+
+		if (offload > AMT_OFFLOAD_MODE_MAX) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_AMT_OFFLOAD_MODE],
+					    "Offload mode is not valid");
+			return -EINVAL;
+		}
+		if (offload != AMT_OFFLOAD_MODE_SOFTWARE &&
+		    nla_get_u32(data[IFLA_AMT_MODE]) != AMT_MODE_RELAY) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_AMT_OFFLOAD_MODE],
+					    "Offload is only valid in relay mode");
+			return -EINVAL;
+		}
+	}
+
 	if (!data[IFLA_AMT_LOCAL_IP] && !data[IFLA_AMT_LOCAL_IP6]) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Local IPv4 or IPv6 attribute is required");
@@ -5802,6 +5819,9 @@ static int amt_newlink(struct net_device *dev,
 
 	amt->net = link_net;
 	amt->mode = nla_get_u32(data[IFLA_AMT_MODE]);
+	amt->offload_mode = data[IFLA_AMT_OFFLOAD_MODE] ?
+			    nla_get_u32(data[IFLA_AMT_OFFLOAD_MODE]) :
+			    AMT_OFFLOAD_MODE_SOFTWARE;
 
 	if (data[IFLA_AMT_MAX_TUNNELS] &&
 	    nla_get_u32(data[IFLA_AMT_MAX_TUNNELS]))
@@ -5998,7 +6018,8 @@ static size_t amt_get_size(const struct net_device *dev)
 	       nla_total_size(sizeof(struct iphdr)) + /* IFLA_AMT_LOCAL_IP */
 	       nla_total_size(sizeof(struct in6_addr)) + /* IFLA_AMT_LOCAL_IP6 */
 	       nla_total_size(sizeof(struct in6_addr)) + /* IFLA_AMT_DISCOVERY_IP6 */
-	       nla_total_size(sizeof(struct in6_addr)); /* IFLA_AMT_REMOTE_IP6 */
+	       nla_total_size(sizeof(struct in6_addr)) + /* IFLA_AMT_REMOTE_IP6 */
+	       nla_total_size(sizeof(__u32)); /* IFLA_AMT_OFFLOAD_MODE */
 }
 
 static int amt_fill_info(struct sk_buff *skb, const struct net_device *dev)
@@ -6068,6 +6089,8 @@ static int amt_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		goto nla_put_failure;
 	if (nla_put_u32(skb, IFLA_AMT_NUM_QUEUES, dev->real_num_tx_queues))
 		goto nla_put_failure;
+	if (nla_put_u32(skb, IFLA_AMT_OFFLOAD_MODE, amt->offload_mode))
+		goto nla_put_failure;
 
 	return 0;
 
diff --git a/include/uapi/linux/amt.h b/include/uapi/linux/amt.h
index de1ae1929..c67a1f763 100644
--- a/include/uapi/linux/amt.h
+++ b/include/uapi/linux/amt.h
@@ -122,6 +122,13 @@ enum {
 	 * AMT_MAX_TUNNELS_PER_SOURCE; raise it on a relay that fronts CGNAT.
 	 */
 	IFLA_AMT_MAX_TUNNELS_PER_SOURCE,
+	/* Relay mode: enum ifla_amt_offload_mode, default
+	 * AMT_OFFLOAD_MODE_SOFTWARE. Replication offload to a provider
+	 * registered on the IFLA_AMT_LINK device (include/net/amt_offload.h).
+	 * Required mode refuses creation with -ENODEV when no usable provider
+	 * is bound. Gateway mode accepts software only.
+	 */
+	IFLA_AMT_OFFLOAD_MODE,
 	__IFLA_AMT_MAX,
 };
 
-- 
2.43.0

