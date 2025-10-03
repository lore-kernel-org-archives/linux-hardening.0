Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972128031D
	for <linux-hardening@vger.kernel.org>; Fri,  3 Oct 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503114; cv=none; b=NG+sUvzy/KC9SMIbMy/e5sc3T8HftBQuE1l/2LeurknE1v2ylddGCv7xcifj9uLOBj97Ft/xXQcls/dhPjlp7RoJX7tfhn0oielJ9zECRKiuUHhRNkrCjK6j7iAL5cBA+d9cYySHOROOF5GA9zPDFclG7bz5IgV/TmTZpvDC3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503114; c=relaxed/simple;
	bh=i/YUf1axjvgBB0oBuLEcFDe6+5YLN/s7LxvMOh+E9SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/WIbhLt0RV2DNGIjCNuG3gDUXXfad1BVntbo9ovqSve2TtkN5+DFEB3BTWD9P5IZjt8vU2N/dMVvWgYPg0n9MSf864niRHdMioaHBmy5LVYrhU+BCN5xTt9vS4ZjdkC7zZcAobl3T8/wJwKL1K7u2qc86XbO6u+GjgRswVNLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=A0BJupCp; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="A0BJupCp"
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id 4QsXvj8ZYeNqi4h8LvSTNr; Fri, 03 Oct 2025 14:51:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4h8Kva9UF0HUD4h8Kv29l0; Fri, 03 Oct 2025 14:51:44 +0000
X-Authority-Analysis: v=2.4 cv=TIhFS0la c=1 sm=1 tr=0 ts=68dfe300
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4oHATN8Nx7vVUZJYxp75bA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=23AC6A14qyjZoQxIM3kA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jV1qtlxBFmkNX+E301lyZjQNxGWe0zxbBvqrtgqEyMg=; b=A0BJupCpk8ltfWzhHrwl2IilfY
	C1cNHLok+ikyxTGyLwqodAQBOPFtv1fh/dbzboQ3JDVqn2jWYvVxuuOtgS1kIEBV/uiPfrCge21XB
	DFH4P1S2iG/+HhWqwLsgfK4Puobet8d4I8pCIytJC1qRXlICNSmAo4nR3VOQ56ugPhr+z8kFUWUAZ
	+EE4Vf0oFkkxpyK2l9Krov50AjghhQVuTU/TVqPqbbdsGPUdSN5UFy/d38bbA5L/O5efLY+wIKcED
	QKCw55R7LLRxp10T6ded/vadv+HioyqN+y7gA+p8/Ji7X+4Uymv+ocCyOFIVfPcbvzv+x176k1jgu
	JFcN7Q+Q==;
Received: from [185.134.146.81] (port=45090 helo=[10.21.53.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v4h8J-00000001gmy-0fZk;
	Fri, 03 Oct 2025 09:51:43 -0500
Message-ID: <b59ed01f-d9d5-4de8-8a12-1e506962b2d9@embeddedor.com>
Date: Fri, 3 Oct 2025 15:51:24 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] btrfs: Avoid -Wflex-array-member-not-at-end warning
To: dsterba@suse.cz, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aN_Zeo7JH9nogwwq@kspp> <20251003143502.GJ4052@suse.cz>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251003143502.GJ4052@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.134.146.81
X-Source-L: No
X-Exim-ID: 1v4h8J-00000001gmy-0fZk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.21.53.44]) [185.134.146.81]:45090
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGxrFil1Av7K9JVVS2ZhtJ4X4ksiR6xjbzDzEVqqK/Ve1iqqnC0sr7kDQ9TUMVaWoaid/RWYS5FgU6wZkbTfzaIkblgjZ7bDXfGgXpZWsleoIaG73b2Z
 5/mp1IlL6L3VRUj/0M7xOZugULcXSQDwaEsdi4v0xv3OjeEWB9LUvZ+wRMNpruAbZiU7O86570r5z3iZ5efTFt82zzNm6dCiW3WcsAq1ujhjIhsASWwG8RJA



On 10/3/25 15:35, David Sterba wrote:
> On Fri, Oct 03, 2025 at 03:11:06PM +0100, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the corresponding
>> structure. Notice that `struct fs_path` is a flexible structure,
>> this is a structure that contains a flexible-array member (`char
>> inline_buf[];` in this case).
> 
> It contains a flexible member but also a padding array and a limit
> calculated for the usable space of inline_buf (FS_PATH_INLINE_SIZE),
> it's not the pattern where flexible array is in the middle of a
> structure and could potentially overwrite other members.

Yep, I notice that while reviewing the context in which this is being
used. :)

> 
>> Fix the following warning:
>>
>> fs/btrfs/send.c:181:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Otheriwse OK to fix the warning.

Thanks.

> 
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   fs/btrfs/send.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>> index 9230e5066fc6..2b7cf49a35bb 100644
>> --- a/fs/btrfs/send.c
>> +++ b/fs/btrfs/send.c
>> @@ -178,7 +178,6 @@ struct send_ctx {
>>   	u64 cur_inode_rdev;
>>   	u64 cur_inode_last_extent;
>>   	u64 cur_inode_next_write_offset;
>> -	struct fs_path cur_inode_path;
>>   	bool cur_inode_new;
>>   	bool cur_inode_new_gen;
>>   	bool cur_inode_deleted;
>> @@ -305,6 +304,9 @@ struct send_ctx {
>>   
>>   	struct btrfs_lru_cache dir_created_cache;
>>   	struct btrfs_lru_cache dir_utimes_cache;
>> +
>> +	/* Must be last --ends in a flexible-array member. */
>                          ^^
> 
> Is this an en dash?

Not sure what you mean.

-Gustavo

> 
>> +	struct fs_path cur_inode_path;
>>   };
>>   
>>   struct pending_dir_move {
>> -- 
>> 2.43.0
>>


