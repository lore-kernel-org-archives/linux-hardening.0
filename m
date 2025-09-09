Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0075226D1D;
	Tue,  9 Sep 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429779; cv=none; b=CXKFKoe6CHtqn/wg9+r5mQNMz0LQtqTgcQ5nK1RrRAWtqeUOlP3ZXDaCjajuKiBicLps2agN47CnZYotHzD+TcM+89hOFotjwxxxab9UmLU6d77zeIe/iu808Vol78GP+uFWrqEzCGsq/cpLWK+IebYgdMafALIFutbzTIJiY40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429779; c=relaxed/simple;
	bh=OUiEyXGSue/Qc0yE11k9Ns0FoQt2oacvNvUxDFL/e5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwFlyNAHBBk0IsdOlVfFYVpS6B7aZV286IBETqyO7Qiny6xnSBh6cTfLeBjZAWZA7uabG6JkR/vLUXd976BAUQvw/2FnQRjSKWkb47W1KxCLKWXDPec5MeQIi/5VJeXAECvgOmh3ICTvh7IucywTeQQID6GvY6R516N2HtYz6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyL/Ba7s; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyL/Ba7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757429777; x=1788965777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OUiEyXGSue/Qc0yE11k9Ns0FoQt2oacvNvUxDFL/e5E=;
  b=kyL/Ba7sAXwbe87nnDQBqrD4uSkzTxanwn0ppyRpvKlvE8OmWJ+xkR2u
   EBS18BafGCCxxLrp3ZvpGY89t3d9pK2edQ+BX/0nBoKOwUyjGi90CyIGe
   oomDpsSvwdw4VIztO+2++iYtbVqIThyjY/wN17a03dM8/MyGwy1fF02a0
   MNyY01G+qqvhmGwetd7jqfhY9UdWVHEXjkcMLX4rBlEjLl3aSCT5k57kG
   TS5crmnX6SA38w7vXKsc78OVicn0yJYh/Eg8fTNUouMVFjLTvegyOvm6z
   5OdHWDu9ohqNx3eOmYl4mWUSkOUsCvthl8JGYYXnNP0y5OnyHp3MWwbJy
   Q==;
X-CSE-ConnectionGUID: btvsHT8HT9ieNgHUUGjdvA==
X-CSE-MsgGUID: lQLdIQ6nTIamWIOS2ZjF+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59862601"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="59862601"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 07:56:16 -0700
X-CSE-ConnectionGUID: MZ6qQ+1FTt+tZ2SdU+KwyQ==
X-CSE-MsgGUID: LchPTtfYR7WBuVhwCI8EuA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2025 07:56:12 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvzlR-0004xT-2N;
	Tue, 09 Sep 2025 14:56:09 +0000
Date: Tue, 9 Sep 2025 22:55:38 +0800
From: kernel test robot <lkp@intel.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
	michal.simek@amd.com, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: Re: [PATCH V5 2/2] i3c: master: Add AMD I3C bus controller driver
Message-ID: <202509092248.xJvRASTq-lkp@intel.com>
References: <20250908112117.205270-3-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908112117.205270-3-manikanta.guntupalli@amd.com>

Hi Manikanta,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.17-rc5 next-20250909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikanta-Guntupalli/dt-bindings-i3c-Add-AMD-I3C-master-controller-support/20250908-192455
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250908112117.205270-3-manikanta.guntupalli%40amd.com
patch subject: [PATCH V5 2/2] i3c: master: Add AMD I3C bus controller driver
config: sh-randconfig-r113-20250909 (https://download.01.org/0day-ci/archive/20250909/202509092248.xJvRASTq-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250909/202509092248.xJvRASTq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509092248.xJvRASTq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/i3c/master/amd-i3c-master.c:559:68: sparse: sparse: dubious: x | !y
   drivers/i3c/master/amd-i3c-master.c:427:13: sparse: sparse: context imbalance in 'xi3c_master_dequeue_xfer' - wrong count at exit
   drivers/i3c/master/amd-i3c-master.c:601:9: sparse: sparse: context imbalance in 'xi3c_master_do_daa' - different lock contexts for basic block
   drivers/i3c/master/amd-i3c-master.c:644:12: sparse: sparse: context imbalance in 'xi3c_master_send_bdcast_ccc_cmd' - wrong count at exit
   drivers/i3c/master/amd-i3c-master.c:680:12: sparse: sparse: context imbalance in 'xi3c_master_send_direct_ccc_cmd' - wrong count at exit
   drivers/i3c/master/amd-i3c-master.c:733:12: sparse: sparse: context imbalance in 'xi3c_master_priv_xfers' - wrong count at exit
   drivers/i3c/master/amd-i3c-master.c:773:12: sparse: sparse: context imbalance in 'xi3c_master_i2c_xfers' - wrong count at exit
   drivers/i3c/master/amd-i3c-master.c:926:65: sparse: sparse: shift too big (32) for type unsigned long

vim +559 drivers/i3c/master/amd-i3c-master.c

   499	
   500	static int xi3c_master_do_daa(struct i3c_master_controller *m)
   501	{
   502		struct xi3c_master *master = to_xi3c_master(m);
   503		struct xi3c_cmd *daa_cmd;
   504		struct xi3c_xfer *xfer;
   505		u8 pid_bufs[XI3C_MAX_DEVS][8];
   506		u8 data, last_addr = 0;
   507		int addr, ret, i;
   508		u8 *pid_buf;
   509	
   510		u64 *pid_bcr_dcr __free(kfree) = kcalloc(XI3C_MAX_DEVS, sizeof(u64),
   511							 GFP_KERNEL);
   512		if (!pid_bcr_dcr)
   513			return -ENOMEM;
   514	
   515		xfer = xi3c_master_alloc_xfer(master, 1);
   516		if (!xfer) {
   517			ret = -ENOMEM;
   518			goto err_daa_mem;
   519		}
   520	
   521		for (i = 0; i < XI3C_MAX_DEVS; i++) {
   522			addr = i3c_master_get_free_addr(m, last_addr + 1);
   523			if (addr < 0) {
   524				ret = -ENOSPC;
   525				goto err_daa;
   526			}
   527			master->daa.addrs[i] = (u8)addr;
   528			last_addr = (u8)addr;
   529		}
   530	
   531		/* Fill ENTDAA CCC */
   532		data = I3C_CCC_ENTDAA;
   533		daa_cmd = &xfer->cmds[0];
   534		daa_cmd->addr = I3C_BROADCAST_ADDR;
   535		daa_cmd->rnw = 0;
   536		daa_cmd->tx_buf = &data;
   537		daa_cmd->tx_len = 1;
   538		daa_cmd->type = XI3C_SDR_MODE;
   539		daa_cmd->tid = XI3C_SDR_TID;
   540		daa_cmd->continued = true;
   541	
   542		ret = xi3c_master_common_xfer(master, xfer);
   543		/* DAA always finishes with CE2_ERROR or NACK_RESP */
   544		if (ret && ret != I3C_ERROR_M2) {
   545			goto err_daa;
   546		} else {
   547			if (ret && ret == I3C_ERROR_M2) {
   548				ret = 0;
   549				goto err_daa;
   550			}
   551		}
   552	
   553		master->daa.index = 0;
   554	
   555		while (true) {
   556			struct xi3c_cmd *cmd = &xfer->cmds[0];
   557	
   558			pid_buf = pid_bufs[master->daa.index];
 > 559			addr = (master->daa.addrs[master->daa.index] << 1) |
   560			       (!parity8(master->daa.addrs[master->daa.index]));
   561	
   562			cmd->tx_buf = (u8 *)&addr;
   563			cmd->tx_len = 1;
   564			cmd->addr = I3C_BROADCAST_ADDR;
   565			cmd->rnw = 1;
   566			cmd->rx_buf = pid_buf;
   567			cmd->rx_len = XI3C_DAA_SLAVEINFO_READ_BYTECOUNT;
   568			cmd->is_daa = true;
   569			cmd->type = XI3C_SDR_MODE;
   570			cmd->tid = XI3C_SDR_TID;
   571			cmd->continued = true;
   572	
   573			ret = xi3c_master_common_xfer(master, xfer);
   574	
   575			/* DAA always finishes with CE2_ERROR or NACK_RESP */
   576			if (ret && ret != I3C_ERROR_M2) {
   577				goto err_daa;
   578			} else {
   579				if (ret && ret == I3C_ERROR_M2) {
   580					xi3c_master_resume(master);
   581					master->daa.index--;
   582					ret = 0;
   583					break;
   584				}
   585			}
   586		}
   587	
   588		kfree(xfer);
   589	
   590		for (i = 0; i < master->daa.index; i++) {
   591			i3c_master_add_i3c_dev_locked(m, master->daa.addrs[i]);
   592	
   593			pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
   594						   get_unaligned_be64(pid_bufs[i]));
   595			dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, pid_bcr_dcr[i]);
   596		}
   597	
   598		return 0;
   599	
   600	err_daa:
   601		kfree(xfer);
   602	err_daa_mem:
   603		xi3c_master_reinit(master);
   604		return ret;
   605	}
   606	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
