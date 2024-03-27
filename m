Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D212EBC4
	for <linux-hardening@vger.kernel.org>; Wed, 27 Mar 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566148; cv=none; b=QHliG+oXPkQ2P2BMBSCzn6tbbO3psuSgBoc6a0G40QV/xBX1SfMSN3JJ2ocemRnw898nhPOrrDKl+TtOS2VWjMoyYIZw69jwdj9YfO+OSvYHbNc/0XhzWnqizywHSNQ6ZenD2Hf8Pua0qkRo2vJi58Dk3ecrYWoX/23ZGPjpcrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566148; c=relaxed/simple;
	bh=tY/kYlCKTZM1U9At1f8pcyF1C2M3Gx00Kx1VbgRTDBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gezXdccZg11oM+rqDoDX0LU1PeKRs+15waqG/JUy3fRJW+hHXlfVjqb5nVlrF09zloPkZqzO0us/vbxpXucmc/cTEsAth4MczmzBaLdd5Z2vSrxTdiLwkxsdU05vyDLgUPWZ7zsVtmeU/Wt+nY+yNfjl2FN+COZiWU/xfSe90sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=o6i/ckCN; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="o6i/ckCN"
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id pWKkrg01gHXmApYXWrx5aJ; Wed, 27 Mar 2024 19:02:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pYXVrzsF6sdAjpYXVr6n20; Wed, 27 Mar 2024 19:02:21 +0000
X-Authority-Analysis: v=2.4 cv=C9LvyxP+ c=1 sm=1 tr=0 ts=66046d3d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=ne6NSq1Het56kcJAOLIA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eTo6rPqoE3ht4O7ovAkyYWoWGnFdaNMGQPNuK9WIyCE=; b=o6i/ckCNzyuwFrbMgNPhUV/iIK
	3PM/clgmp92OTK7km9UWKK3UqAH4hrt0zx3XEjFdYpYEzsTUFIGpyaKdCQjAVv6bva63+teWqnhJu
	EqhtVByQ8opkoxvV8VUDOJzxjOcK3voxKJIVhB24rVrVtFxXGvPCibvIf57k521jiBgy6fK+jAK3Z
	PuWiqTAcBnkQSx19vahiRxSAxWW/3xnVciMPfGXJ4+N3+kkI0Aai4sfkGZ2AIzdIA5XXRYz/T+dmj
	9I36Qcxjft97TligGxtyiww4umuSa1NyaE7DSpOpi3TMaFp05MzOkMf4UxAgGVTzi3Ly/3IiNP6RB
	IsZNowbw==;
Received: from [201.172.173.147] (port=58918 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpYXU-003fPc-23;
	Wed, 27 Mar 2024 14:02:20 -0500
Message-ID: <29be66cd-e752-4c5e-a660-7b668e49ff9e@embeddedor.com>
Date: Wed, 27 Mar 2024 13:02:19 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: wil6210: Avoid -Wflex-array-member-not-at-end
 warning
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgOEoCWguq3n1OqQ@neat>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZgOEoCWguq3n1OqQ@neat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpYXU-003fPc-23
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:58918
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIaDA3/dAwyeCqefeDYMp04fWIhJOPMCoT/rd05+oA0eE8foobnibb3Fl//gPkr35AlhUZX53VMLnCqzIPNOmmo0lz6SNTuW+XLI6ootBO8Xdp1g0joy
 SfD2Q102zpkeTk0X8KEXfNyhkWqn/l3Rcc3IZj1sB13DqMIycKK4cQUOF3QMYBC24jWtrgyAPnwJ3kYT5pAQKtNpEuyOgExlN1Pw/rmkhwJCra3eMWN5a9EW

Hi all,

Please, drop this.

The following patch replaces it:

https://lore.kernel.org/linux-hardening/ZgRsn72WkHzfCUsa@neat/

Thanks
--
Gustavo

On 3/26/24 20:29, Gustavo A. R. Silva wrote:
> Use the `DEFINE_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/net/wireless/ath/wil6210/wmi.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
> index 6fdb77d4c59e..cc0ad70f0d01 100644
> --- a/drivers/net/wireless/ath/wil6210/wmi.c
> +++ b/drivers/net/wireless/ath/wil6210/wmi.c
> @@ -4014,28 +4014,23 @@ int wmi_set_cqm_rssi_config(struct wil6210_priv *wil,
>   	struct net_device *ndev = wil->main_ndev;
>   	struct wil6210_vif *vif = ndev_to_vif(ndev);
>   	int rc;
> -	struct {
> -		struct wmi_set_link_monitor_cmd cmd;
> -		s8 rssi_thold;
> -	} __packed cmd = {
> -		.cmd = {
> -			.rssi_hyst = rssi_hyst,
> -			.rssi_thresholds_list_size = 1,
> -		},
> -		.rssi_thold = rssi_thold,
> -	};
>   	struct {
>   		struct wmi_cmd_hdr hdr;
>   		struct wmi_set_link_monitor_event evt;
>   	} __packed reply = {
>   		.evt = {.status = WMI_FW_STATUS_FAILURE},
>   	};
> +	DEFINE_FLEX(struct wmi_set_link_monitor_cmd, cmd,
> +		    rssi_thresholds_list, rssi_thresholds_list_size, 1);
> +
> +	cmd->rssi_hyst = rssi_hyst;
> +	cmd->rssi_thresholds_list[0] = rssi_thold;
>   
>   	if (rssi_thold > S8_MAX || rssi_thold < S8_MIN || rssi_hyst > U8_MAX)
>   		return -EINVAL;
>   
> -	rc = wmi_call(wil, WMI_SET_LINK_MONITOR_CMDID, vif->mid, &cmd,
> -		      sizeof(cmd), WMI_SET_LINK_MONITOR_EVENTID,
> +	rc = wmi_call(wil, WMI_SET_LINK_MONITOR_CMDID, vif->mid, cmd,
> +		      sizeof(*cmd), WMI_SET_LINK_MONITOR_EVENTID,
>   		      &reply, sizeof(reply), WIL_WMI_CALL_GENERAL_TO_MS);
>   	if (rc) {
>   		wil_err(wil, "WMI_SET_LINK_MONITOR_CMDID failed, rc %d\n", rc);
