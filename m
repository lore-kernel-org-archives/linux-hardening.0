Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B040C03
	for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214532; cv=none; b=ZVYH2dBRz4FNsQ745fPudpOjZqeHCKagfZ3VxnuNjyDY11SiqfrFCMn4DOTCKBowmjLSsClge5xwdMUEbH6TzQK8sPii1pumTrg3EB3OSVjyzdT7yMcyZGvmfD2hUIMrFTAKe/PxNNAjS0QwiZsXQtF4KgV9OJnO9FdavubSdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214532; c=relaxed/simple;
	bh=5zN/nlkdigmowTno5aefO+FA6IRgH+F11im0EfqGZ9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1jxNHz5qCGu0jZMu/FnBAFDN6SD7Nv9kOvijJYoywartckWeNPogf8AozEQqkiCs7BhDDlt7kmfVaYTXPdol5DcWQtSYuBMp5XmVurdGQKAXXsKkBtIA7jBDo5sLxEMyZWuBdKtSykRrvNJotyNYeBpLa6haGTpnbKS350x8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=VQBkdKJO; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="VQBkdKJO"
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id oyPfsbl34qvuop1FjsYOFa; Fri, 13 Sep 2024 08:02:03 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id p1FisEauhV2ivp1FisPamW; Fri, 13 Sep 2024 08:02:02 +0000
X-Authority-Analysis: v=2.4 cv=OLns3jaB c=1 sm=1 tr=0 ts=66e3f17a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=rpUMG24A1zG+UrzXDtAMsg==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=aLwh8JLyV31UtTAnTHUA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Oq+rHKrgDWYswOs+o2qKxq1SVtxHkyDBarnNx1v0+ek=; b=VQBkdKJOS0dDpwAJ5SFGZOvc9T
	arBxAuPCfMvmK4z7E85ntMXZw/G5HU9YjRPEm1HE6MdK5ZZFsYKEgkymCKW7KTMedYhYpBvxeV3Qb
	zs0W61L3IU6yfE0bIbIPY+MrAHP7eKAF3w0ftwiFtjEzcILMfEpJR1DfsqXW1zzezf1keARg4vB2r
	/xZhfHdMc61WDrQTRfpberEEv48qHl0O7hCH1nuMjBwnkAqePxnLtAZ7DgppbcVUNNquGfi+1/EAg
	WRHoI+PTDSY35A4B9uEBCQ0AlukNCv9Kw3h5iHGhfgxiDBdjmv/GGYJ8+dVWrfPPXEaQg391Sfeqb
	lPeo9daw==;
Received: from [185.44.53.103] (port=49374 helo=[192.168.1.187])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sp1Fh-003bEM-1q;
	Fri, 13 Sep 2024 03:02:01 -0500
Message-ID: <4caca5e1-c8ea-46dd-a6f2-532030a48454@embeddedor.com>
Date: Fri, 13 Sep 2024 10:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: iwlwifi: dvm: Avoid
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Zr5QR03+wyw571zd@elsanto>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Zr5QR03+wyw571zd@elsanto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.44.53.103
X-Source-L: No
X-Exim-ID: 1sp1Fh-003bEM-1q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.187]) [185.44.53.103]:49374
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJyhU2tGFPpAUa7X3u1Fcztan1m7jYw+LRuPkJNwg5XSA8C570zw6WMWSZxKNy1BnsUMQyCC15WhKx4HWmWpLJkkmWkQrWfvtFKa1ZV3trsvG1jHDCs4
 Pqi+jOjb0VFqQCOBMwmx9MH+7y6hxIJklXEreat/WB6OosTEt0tqG1ze4LUN6/Wu+4JW2y1s7hhMp7RCfx4jy47lWzio8MP6fh24WoSrpDpYuRaBeGvp+44y

Hi all,

Friendly ping: who can take this, please? :)

Thanks
--
Gustavo

On 15/08/24 21:00, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of multiple other structs, we use the `__struct_group()`
> helper to create a new tagged `struct iwl_tx_cmd_hdr`. This structure
> groups together all the members of the flexible `struct iwl_tx_cmd`
> except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct members currently causing
> trouble from `struct iwl_tx_cmd` to `struct iwl_tx_cmd_hdr`.
> 
> We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> This approach avoids having to implement `struct iwl_tx_cmd_hdr`
> as a completely separate structure, thus preventing having to maintain
> two independent but basically identical structures, closing the door
> to potential bugs in the future.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/net/wireless/intel/iwlwifi/dvm/commands.h:2315:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/dvm/commands.h:2426:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   .../net/wireless/intel/iwlwifi/dvm/commands.h | 154 +++++++++---------
>   1 file changed, 78 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
> index 3f49c0bccb28..96ea6c8dfc89 100644
> --- a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
> +++ b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
> @@ -1180,85 +1180,87 @@ struct iwl_dram_scratch {
>   } __packed;
>   
>   struct iwl_tx_cmd {
> -	/*
> -	 * MPDU byte count:
> -	 * MAC header (24/26/30/32 bytes) + 2 bytes pad if 26/30 header size,
> -	 * + 8 byte IV for CCM or TKIP (not used for WEP)
> -	 * + Data payload
> -	 * + 8-byte MIC (not used for CCM/WEP)
> -	 * NOTE:  Does not include Tx command bytes, post-MAC pad bytes,
> -	 *        MIC (CCM) 8 bytes, ICV (WEP/TKIP/CKIP) 4 bytes, CRC 4 bytes.i
> -	 * Range: 14-2342 bytes.
> -	 */
> -	__le16 len;
> -
> -	/*
> -	 * MPDU or MSDU byte count for next frame.
> -	 * Used for fragmentation and bursting, but not 11n aggregation.
> -	 * Same as "len", but for next frame.  Set to 0 if not applicable.
> -	 */
> -	__le16 next_frame_len;
> -
> -	__le32 tx_flags;	/* TX_CMD_FLG_* */
> -
> -	/* uCode may modify this field of the Tx command (in host DRAM!).
> -	 * Driver must also set dram_lsb_ptr and dram_msb_ptr in this cmd. */
> -	struct iwl_dram_scratch scratch;
> -
> -	/* Rate for *all* Tx attempts, if TX_CMD_FLG_STA_RATE_MSK is cleared. */
> -	__le32 rate_n_flags;	/* RATE_MCS_* */
> -
> -	/* Index of destination station in uCode's station table */
> -	u8 sta_id;
> -
> -	/* Type of security encryption:  CCM or TKIP */
> -	u8 sec_ctl;		/* TX_CMD_SEC_* */
> -
> -	/*
> -	 * Index into rate table (see REPLY_TX_LINK_QUALITY_CMD) for initial
> -	 * Tx attempt, if TX_CMD_FLG_STA_RATE_MSK is set.  Normally "0" for
> -	 * data frames, this field may be used to selectively reduce initial
> -	 * rate (via non-0 value) for special frames (e.g. management), while
> -	 * still supporting rate scaling for all frames.
> -	 */
> -	u8 initial_rate_index;
> -	u8 reserved;
> -	u8 key[16];
> -	__le16 next_frame_flags;
> -	__le16 reserved2;
> -	union {
> -		__le32 life_time;
> -		__le32 attempt;
> -	} stop_time;
> -
> -	/* Host DRAM physical address pointer to "scratch" in this command.
> -	 * Must be dword aligned.  "0" in dram_lsb_ptr disables usage. */
> -	__le32 dram_lsb_ptr;
> -	u8 dram_msb_ptr;
> -
> -	u8 rts_retry_limit;	/*byte 50 */
> -	u8 data_retry_limit;	/*byte 51 */
> -	u8 tid_tspec;
> -	union {
> -		__le16 pm_frame_timeout;
> -		__le16 attempt_duration;
> -	} timeout;
> -
> -	/*
> -	 * Duration of EDCA burst Tx Opportunity, in 32-usec units.
> -	 * Set this if txop time is not specified by HCCA protocol (e.g. by AP).
> -	 */
> -	__le16 driver_txop;
> -
> +	/* New members MUST be added within the __struct_group() macro below. */
> +	__struct_group(iwl_tx_cmd_hdr, __hdr, __packed,
> +		/*
> +		 * MPDU byte count:
> +		 * MAC header (24/26/30/32 bytes) + 2 bytes pad if 26/30 header size,
> +		 * + 8 byte IV for CCM or TKIP (not used for WEP)
> +		 * + Data payload
> +		 * + 8-byte MIC (not used for CCM/WEP)
> +		 * NOTE:  Does not include Tx command bytes, post-MAC pad bytes,
> +		 *        MIC (CCM) 8 bytes, ICV (WEP/TKIP/CKIP) 4 bytes, CRC 4 bytes.i
> +		 * Range: 14-2342 bytes.
> +		 */
> +		__le16 len;
> +
> +		/*
> +		 * MPDU or MSDU byte count for next frame.
> +		 * Used for fragmentation and bursting, but not 11n aggregation.
> +		 * Same as "len", but for next frame.  Set to 0 if not applicable.
> +		 */
> +		__le16 next_frame_len;
> +
> +		__le32 tx_flags;	/* TX_CMD_FLG_* */
> +
> +		/* uCode may modify this field of the Tx command (in host DRAM!).
> +		 * Driver must also set dram_lsb_ptr and dram_msb_ptr in this cmd. */
> +		struct iwl_dram_scratch scratch;
> +
> +		/* Rate for *all* Tx attempts, if TX_CMD_FLG_STA_RATE_MSK is cleared. */
> +		__le32 rate_n_flags;	/* RATE_MCS_* */
> +
> +		/* Index of destination station in uCode's station table */
> +		u8 sta_id;
> +
> +		/* Type of security encryption:  CCM or TKIP */
> +		u8 sec_ctl;		/* TX_CMD_SEC_* */
> +
> +		/*
> +		 * Index into rate table (see REPLY_TX_LINK_QUALITY_CMD) for initial
> +		 * Tx attempt, if TX_CMD_FLG_STA_RATE_MSK is set.  Normally "0" for
> +		 * data frames, this field may be used to selectively reduce initial
> +		 * rate (via non-0 value) for special frames (e.g. management), while
> +		 * still supporting rate scaling for all frames.
> +		 */
> +		u8 initial_rate_index;
> +		u8 reserved;
> +		u8 key[16];
> +		__le16 next_frame_flags;
> +		__le16 reserved2;
> +		union {
> +			__le32 life_time;
> +			__le32 attempt;
> +		} stop_time;
> +
> +		/* Host DRAM physical address pointer to "scratch" in this command.
> +		 * Must be dword aligned.  "0" in dram_lsb_ptr disables usage. */
> +		__le32 dram_lsb_ptr;
> +		u8 dram_msb_ptr;
> +
> +		u8 rts_retry_limit;	/*byte 50 */
> +		u8 data_retry_limit;	/*byte 51 */
> +		u8 tid_tspec;
> +		union {
> +			__le16 pm_frame_timeout;
> +			__le16 attempt_duration;
> +		} timeout;
> +
> +		/*
> +		 * Duration of EDCA burst Tx Opportunity, in 32-usec units.
> +		 * Set this if txop time is not specified by HCCA protocol (e.g. by AP).
> +		 */
> +		__le16 driver_txop;
> +
> +	);
>   	/*
>   	 * MAC header goes here, followed by 2 bytes padding if MAC header
>   	 * length is 26 or 30 bytes, followed by payload data
>   	 */
> -	union {
> -		DECLARE_FLEX_ARRAY(u8, payload);
> -		DECLARE_FLEX_ARRAY(struct ieee80211_hdr, hdr);
> -	};
> +	struct ieee80211_hdr hdr[];
>   } __packed;
> +static_assert(offsetof(struct iwl_tx_cmd, hdr) == sizeof(struct iwl_tx_cmd_hdr),
> +	      "struct member likely outside of __struct_group()");
>   
>   /*
>    * TX command response is sent after *agn* transmission attempts.
> @@ -2312,7 +2314,7 @@ struct iwl_scan_cmd {
>   
>   	/* For active scans (set to all-0s for passive scans).
>   	 * Does not include payload.  Must specify Tx rate; no rate scaling. */
> -	struct iwl_tx_cmd tx_cmd;
> +	struct iwl_tx_cmd_hdr tx_cmd;
>   
>   	/* For directed active scans (set to all-0s otherwise) */
>   	struct iwl_ssid_ie direct_scan[PROBE_OPTION_MAX];
> @@ -2423,7 +2425,7 @@ struct iwlagn_beacon_notif {
>    */
>   
>   struct iwl_tx_beacon_cmd {
> -	struct iwl_tx_cmd tx;
> +	struct iwl_tx_cmd_hdr tx;
>   	__le16 tim_idx;
>   	u8 tim_size;
>   	u8 reserved1;
